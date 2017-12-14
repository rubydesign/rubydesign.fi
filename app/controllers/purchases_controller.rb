# encoding : utf-8
class PurchasesController < AdminController

  before_action :load_purchase, :only => [:show, :edit, :update , :order , :receive , :inventory]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Purchase.search params[:q]
    @purchase_scope = @q.result(:distinct => true)
    @purchases = @purchase_scope.includes(:basket => {:items => :product} ).paginate( :page => params[:page],:per_page => 20 ).to_a
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
    @products = Product.where(supplier_id: @purchase.supplier_id)
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

  protected

  def load_purchase
    @purchase = Purchase.where( :id => params[:id]).includes( :basket => {:items => {:product => :supplier}} ).first
  end

  private

  def params_for_model
    params.require(:purchase).permit(:name,:ordered_on,:received_on,:basket_id)
  end
end
