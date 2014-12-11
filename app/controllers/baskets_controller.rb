# encoding : utf-8
class BasketsController < AdminController

  before_filter :load_basket, :only => [:show, :edit, :change , :update, :destroy , :order , 
                                        :checkout, :purchase , :discount , :ean]

  def index
    @q = Basket.search( params[:q] )
    @basket_scope = @q.result( :distinct => true )
    @baskets = @basket_scope.includes({:items => :product} , :kori).paginate( :page => params[:page], :per_page => 20 )
  end

  def checkout
    if @basket.empty?
      render :edit , :notice => t(:basket_empty)
      return
    end
    order = @basket.kori || Order.new( :basket => @basket )
    order.pos_checkout( current_clerk.email )
    order.save!
    styles = OfficeClerk.config(:print_styles)
    if(styles && styles.split.include?("receipt"))
      redirect_to receipt_order_path(order)
    else
      redirect_to order_path(order)
    end
  end

  def show
    gon.basket_id = @basket.id
  end

  #as an action this order is meant as a verb, ie order this basket
  def order
    if @basket.empty?
      render :edit , :notice => t(:basket_empty)
      return
    end
    order = Order.create! :basket => @basket , :email => current_clerk.email , :ordered_on => Date.today
    redirect_to :action => :show , :controller => :orders , :id => order.id
  end

  def purchase
    if @basket.empty?
      render :edit , :notice => t(:basket_empty)
      return
    end
    if @basket.locked
      render :show , :notice => t(:basket_locked)
      return
    end
    purchase = Purchase.create! :basket => @basket
    redirect_to :action => :show , :controller => :purchases , :id => purchase.id
  end

  def new
    @basket = Basket.create!
    render :edit
  end

  # refactor discount out of edit
  def discount
    if discount = params[:discount]
      if i_id = params[:item]
        item = @basket.items.find { |item| item.id.to_s == i_id }
        item_discount( item , discount )
      else
        @basket.items.each do |item|
          item_discount( item , discount )
        end
      end
      @basket.save!
    else
      flash[:error] = "No discount given"
    end
    redirect_to :action => :edit
  end

  # ean search at the top of basket edit
  def ean
    return if locked?
    ean = params[:ean]
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
    redirect_to :action => :edit    
  end

  def edit
    return if locked?
    if p_id = (params[:add] || params[:delete])
      add = params[:add].blank? ? -1 : 1
      @basket.add_product Product.find(p_id) , add
      flash.now.notice = params[:add] ? t('product_added') : t('item_removed')
    end
    @basket.save!
  end

  def create
    @basket = Basket.create(params_for_basket)
    if @basket.save
      redirect_to basket_path(@basket), :notice => t(:create_success, :model => "basket")
    else
      render :edit
    end
  end

  def update
    return if locked?
    @basket.update_attributes(params_for_basket)
    flash.notice = t(:update_success, :model => "basket")
    redirect_to edit_basket_path(@basket)
  end

  def destroy
    # the idea is that you can't delete a basket once something has been "done" with it (order..)
    @basket.destroy unless @basket.kori_type
    redirect_to baskets_url
  end

  private

  # check if the @basket is locked (no edits allowed)
  # and if so redirect to show
  def locked?
    return false unless @basket.locked
    redirect_to :action => :show , :notice => t('basket_locked')
    return true
  end

  def item_discount item , discount
    item.price = (item.product.price * ( 1.0 - discount.to_f/100.0 )).round(2)
    item.save!
  end

  def load_basket
    @basket = Basket.find(params[:id])
    session[:basket] = nil # used to change links on product page, null when we come back
  end

  def params_for_basket
    return {} if params[:basket].blank? or params[:basket].empty?
    params.require(:basket).permit( :items_attributes => [:quantity , :price , :id] )
  end
end

