# encoding : utf-8
class PurchasesController < AdminController

  before_action :load_purchase, :only => [:show, :edit, :update , :order , :receive , :inventory,:destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Purchase.search params[:q]
    @purchase_scope = @q.result(:distinct => true)
    @purchases = @purchase_scope.includes(:basket => {:items => :product} ).page( params[:page])
  end

  def show
  end

  # order this from supplier
  def order
    @purchase.order!
    redirect_to purchase_path(@purchase), :notice => t(:ordered)
  end

  # receive the stuff (ie add to inventory)
  def receive
    items = @purchase.receive!
    redirect_to purchase_path(@purchase), :notice => [t(:received) ,items ,t(:items)].join(" ")
  end

  # receive the stuff (ie add to inventory)
  def inventory
    items = @purchase.inventory!
    flash.notice = [t(:inventorized) ,items ,t(:items)].join(" ")
    redirect_to purchase_path(@purchase)
  end

  def new
    today = Date.today
    basket = Basket.create!
    @purchase = Purchase.new :name => "#{I18n.t(:purchase)} #{I18n.l(today)}" , :basket => basket
    if( supplier_id = params[:supplier])
      @purchase.supplier = Supplier.find( supplier_id )
    end
    @purchase.save!
    redirect_to edit_basket_path basket
  end

  def edit
    if( @purchase.basket.locked?)
      redirect_to purchase_path(@purchase) , notice: "Cant edit, locked"
    end
    create_data
  end

  def update
    respond_to do |format|
      if @purchase.update_attributes(params_for_model)
        format.html { redirect_to purchase_path(@purchase), :notice => t(:update_success, :model => "purchase") }
        format.json { respond_with_bip(@purchase) }
      else
        format.html { render :action => :show }
        format.json { respond_with_bip(@purchase) }
      end
    end
  end

  def destroy
    # the idea is that you can't delete a basket once something has been "done" with it (order..)
    if @purchase.basket.locked?
      flash.notice = t('basket_locked')
    else
      flash.notice = t('purchase') + " " + t(:deleted)
      @purchase.basket.destroy
      @purchase.destroy
    end
    redirect_to purchases_path
  end

  protected
  def create_data
    @products = Product.where(supplier_id: @purchase.supplier_id).
                        where("stock_level > ?", 0).
                        includes(:category)
    @ordered_products = Hash.new(0)
    @orders =  Order.where("created_at > ?" ,Time.now - 8.weeks).where(shipped_on: nil)
    @orders.includes(basket: {items: :product}).each do |order|
      order.basket.items.each{ |item| @ordered_products[item.product_id] += item.quantity}
    end
    @basket = @purchase.basket
  end

  def load_purchase
    @purchase = Purchase.where( :id => params[:id]).includes( :basket => {:items => {:product => :supplier}} ).first
  end

  private

  def params_for_model
    params.require(:purchase).permit(:name,:ordered_on,:received_on,:basket_id)
  end
end
