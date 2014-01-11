# encoding : utf-8
class BasketsController < AdminController

  before_filter :load_basket, :only => [:show, :edit, :change , :update, :destroy , :order]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:basket)
    @q = Basket.search( params[:q] , :include => {:items => :product} )
    @basket_scope = @q.result( :distinct => true ).sorting( params[:sorting])
    @basket_scope_for_scope = @basket_scope.dup
    unless params[:scope].blank?
      @basket_scope = @basket_scope.send(params[:scope])
    end
    @baskets = @basket_scope.paginate( :page => params[:page], :per_page => 20 ).to_a
  end

  def print
    unless @order.payment_ids.empty?
      @order.payments.first.delete unless @order.payments.first.amount == @order.total
    end
    if @order.payment_ids.empty?
      payment = Spree::Payment.new
      payment.payment_method = Spree::PaymentMethod.find_by_type_and_environment( "Spree::PaymentMethod::Check" , Rails.env)
      payment.amount = @order.total 
      payment.order = @order 
      payment.save!
      payment.capture!
    end
    @order.state = "complete"
    @order.completed_at = Time.now
    @order.create_tax_charge!
    @order.finalize!
    @order.save!
    url = SpreePos::Config[:pos_printing]
    url = url.sub("number" , @order.number.to_s)
    redirect_to url
  end

  def show
  end
  
  #as an action this order is mean as a verb, ie order this basket
  def order
    order = Order.for_basket @basket
    redirect_to :action => :show , :controller => :orders , :id => order.id
  end
  
  def new
    @basket = Basket.create! :name => "cart"
    render "show"
  end

  def edit
    if pid = params[:add]
      item = @basket.items.find { |item| item.id.to_s == pid }
      item.quantity += 1
      item.save
#      flash.notice = t('product_added')
    end
    if pid = params[:delete]
      item = @basket.items.find { |item| item.id.to_s == pid }
      item.quantity -= 1
      if item.quantity == 0
        @basket.items.delete item
      else
        item.save
      end
#      flash.notice = t('item_removed') 
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
    end
    if ean = params[:ean]
      prod = Product.find_by_ean ean
      if(prod)
        @basket.add_product prod
      else
        session[:search] ||= {}
        session[:search][:product] =  {"name_cont"=> ean}
        session[:basket] = @basket.id
        redirect_to :action => :index , :controller => :products
        return
      end
    end
    redirect_to  :action => :show
  end
  
  def create
    @basket = Basket.create(params_for_basket)
    if @basket.save
      redirect_to basket_path(@basket), :flash => { :notice => t(:create_success, :model => "basket") }
    else
      render :action => "new"
    end
  end

  def update
    if @basket.update_attributes(params_for_basket)
      redirect_to basket_path(@basket), :flash => { :notice => t(:update_success, :model => "basket") }
    else
      render :action => "show" 
    end
  end

  def destroy
    @basket.destroy
    redirect_to baskets_url 
  end

  def inventory
    if @order.state == "complete"
      flash[:error] = "Order was already completed (printed), please start with a new customer to add inventory"
      redirect_to :action => :show 
      return
    end
    as = params[:as]
    num = 0 
    prods = @order.line_items.count
    @order.line_items.each do |item |
      variant = item.variant
      num += item.quantity
      if as
        variant.on_hand = item.quantity
      else
        variant.on_hand += item.quantity
      end
      variant.save!
    end
    @order.line_items.clear
    flash.notice = "Total of #{num} items #{as ? 'inventoried': 'added'} for #{prods} products "     
    redirect_to :action => :show 
  end

  private

  def item_discount item , discount
    item.price = item.product.price * ( 1.0 - discount.to_f/100.0 )
    item.save!
  end
  
  def load_basket
    @basket = Basket.find(params[:id])
    session[:basket] = nil # used to change links on product page, null when we come back
  end

  def params_for_basket
    params.require(:basket).permit(:name , :items_attributes => [:quantity , :price , :id] )
  end
end

