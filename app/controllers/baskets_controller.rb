# encoding : utf-8
class BasketsController < AdminController

  before_filter :load_basket, :only => [:show, :edit, :change , :update, :destroy , :order , :checkout, :purchase]

  def index
    @q = Basket.search( params[:q] )
    @basket_scope = @q.result( :distinct => true )
    @baskets = @basket_scope.includes({:items => :product} , :kori).paginate( :page => params[:page], :per_page => 20 )
  end

  def checkout
    if @basket.empty?
      flash.notice = t(:basket_empty)
      render :edit
      return
    end
    order = @basket.kori || Order.new( :basket => @basket )
    order.pos_checkout( current_clerk.email )
    order.save!
    redirect_to :action => :invoice , :controller => :orders , :id => order.id
  end

  def show
  end

  #as an action this order is mean as a verb, ie order this basket
  def order
    if @basket.empty?
      flash.notice = t(:basket_empty)
      render :edit
      return
    end
    order = Order.create! :basket => @basket , :email => current_clerk.email , :orderd_on => Date.today
    redirect_to :action => :show , :controller => :orders , :id => order.id
  end

  def purchase
    if @basket.empty?
      flash.notice = t(:basket_empty)
      render :edit 
      return
    end
    if @basket.locked
      flash.notice = t(:basket_locked)
      render :show
      return
    end
    purchase = Purchase.create! :basket => @basket
    redirect_to :action => :show , :controller => :purchases , :id => purchase.id
  end

  def new
    @basket = Basket.create!
    render :edit
  end

  def edit
    if( @basket.locked)
      flash.notice = t('basket_locked')
      redirect_to  :action => :show
      return
    end
    if pid = params[:add]
      item = @basket.items.find { |item| item.id.to_s == pid }
      item.quantity += 1
      item.save
      flash.notice = t('product_added')
    end
    if pid = params[:delete]
      item = @basket.items.find { |item| item.id.to_s == pid }
      item.quantity -= 1
      if item.quantity == 0
        @basket.items.destroy item
      else
        item.save
      end
      flash.notice = t('item_removed')
    end
    if discount = params[:discount]
      if i_id = params[:item]
        item = @basket.items.find { |item| item.id.to_s == i_id }
        item_discount( item , discount )
      else
        @basket.items.each do |item|
          item_discount( item , discount )
        end
      end
    end
    if p_id = params[:product]
      prod = Product.find p_id
      #errors ?
      @basket.add_product prod
      flash.notice = t('product_added')
    end
    if ean = params[:ean]
      ean.sub!("P+" , "P-") if ean[0,2] == "P+"
      prod = Product.find_by_ean ean
      if(prod)
        @basket.add_product prod
      else
        prod = Product.find_by_scode ean
        if(prod)
          @basket.add_product prod
        else
          # stor the basket in the session ( or the url ???)
          redirect_to :action => :index, :controller => :products, 
                :q => {"name_or_product_name_cont"=> ean},:basket => @basket.id
          return
        end
      end
    end
    @basket.save!
  end

  def create
    @basket = Basket.create(params_for_basket)
    if @basket.save
      redirect_to basket_path(@basket), :flash => { :notice => t(:create_success, :model => "basket") }
    else
      render :edit
    end
  end

  def update
    if not @basket.locked and @basket.update_attributes(params_for_basket)
       flash.notice = t(:update_success, :model => "basket")
       redirect_to edit_basket_path(@basket)
    else
      flash.notice = t('basket_locked') if @basket.locked
      render :action => :show
    end
  end

  def destroy
    # the idea is that you can't delete a basket once something has been "done" with it (order..)
    @basket.destroy unless @basket.kori_type
    redirect_to baskets_url
  end

  def inventory
    if @order.state == "complete"
      flash[:error] = "Order was already completed (printed), please start with a new customer to add inventory"
      render :edit
      return
    end
    as = params[:as]
    num = 0
    prods = @order.basket.items.length
    @order.basket.items.each do |item |
      variant = item.variant
      num += item.quantity
      if as
        variant.on_hand = item.quantity
      else
        variant.on_hand += item.quantity
      end
      variant.save!
    end
    @order.basket.items.clear
    flash.notice = "Total of #{num} items #{as ? 'inventoried': 'added'} for #{prods} products "
    render :edit
  end

  private

  def item_discount item , discount
    item.price = (item.product.price * ( 1.0 - discount.to_f/100.0 )).round(2)
    item.save!
  end

  def load_basket
    @basket = Basket.find(params[:id])
    session[:basket] = nil # used to change links on product page, null when we come back
  end

  def params_for_basket
    params.require(:basket).permit( :items_attributes => [:quantity , :price , :id] )
  end
end

