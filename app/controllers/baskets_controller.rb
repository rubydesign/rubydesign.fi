# encoding : utf-8
class BasketsController < AdminController
  include BasketsHelper

  before_action :load_basket, :only => [:show, :edit, :change , :update, :destroy , :order ,
                                         :purchase , :discount , :ean , :zero]

  def index
    @q = Basket.ransack( params[:q] )
    @basket_scope = @q.result( :distinct => true )
    @baskets = @basket_scope.includes({:items => :product} , :kori).page(params[:page] )
  end

  def show
  end

  def zero
    @basket.zero_prices!
    render :edit
  end

  #as an action this order is meant as a verb, ie order this basket
  def order
    if @basket.empty?
      return render :edit , :notice => t(:basket_empty)
    end
    order = Order.create! :basket => @basket , :email => current_clerk.email , :ordered_on => Date.today
    redirect_to order_path(order)
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
    redirect_to purchase_path(purchase)
  end

  def new
    @basket = Basket.create!
    render :edit
  end

  # refactor discount out of edit
  def discount
    if discount = params[:discount]
      if i_id = params[:item]
        item = @basket.items.find { |it| it.id.to_s == i_id }
        item_discount( item , discount )
      else
        @basket.items.each do |it|
          item_discount( it , discount )
        end
      end
      @basket.save!
    else
      flash[:error] = "No discount given"
    end
    redirect_to edit_basket_path(@basket)
  end

  # ean search at the top of basket edit
  def ean
    return if redirect_if_locked
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
        redirect_to products_path(:q => {"name_cont"=> ean},:basket => @basket.id)
        return
      end
    end
    redirect_to edit_basket_path(@basket)
  end

  def edit
    return if redirect_if_locked
    if p_id = (params[:add] || params[:remove])
      add = params[:add].blank? ? -1 : 1
      @basket.add_product Product.find(p_id) , add
      flash.now.notice = params[:add] ? t('product_added') : t('item_removed')
    elsif prod_id = params[:delete]
      @basket.remove_product Product.find(prod_id)
      flash.now.notice = t('item_removed')
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
    return if redirect_if_locked
    respond_to do |format|
      if @basket.update_attributes(params_for_basket)
        format.html do
          flash.notice = t(:update_success, :model => "basket")
          redirect_to edit_basket_path(@basket)
        end
        format.json { render( partial: "baskets/basket.json" , status: :ok) }
      else
        format.html { render :edit }
        format.json { render json: {}, status: :error }
      end
    end
  end

  def destroy
    # the idea is that you can't delete a basket once something has been "done" with it (order..)
    if @basket.locked?
      flash.notice = t('basket_locked')
    else
      flash.notice = t('basket') + " " + t(:deleted)
      @basket.destroy
    end
    redirect_to baskets_path
  end

  private

  # check if the @basket is locked (no edits allowed)
  # and if so redirect to show
  # return if redirect happened
  def redirect_if_locked
    if @basket.locked?
      flash.notice = t('basket_locked')
      redirect_to basket_path(@basket)
      return true
    end
    return false
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
    params.require(:basket).permit( :items_attributes => [:quantity ,:name, :price , :id, :product_id] )
  end
end
