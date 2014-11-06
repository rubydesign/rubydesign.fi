# encoding : utf-8
class PurchasesController < AdminController

  before_filter :load_purchase, :only => [:show, :edit, :update , :order , :receive , :inventory]

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
    redirect_to purchase_path(@purchase), :notice => [t(:inventorized) ,items ,t(:items)].join(" ")
  end

  def new
    @purchase = Purchase.new
    render :edit
  end

  def edit

  end

  def create
    @purchase = Purchase.create(params_for_model)
    if @purchase.save
      redirect_to purchase_path(@purchase), :notice => t(:create_success, :model => "purchase")
    else
      render :edit
    end
  end

  def update
    if @purchase.update_attributes(params_for_model)
      redirect_to purchase_path(@purchase), :notice => t(:update_success, :model => "purchase")
    else
      render :action => :edit
    end
  end

  private

  def load_purchase
    @purchase = Purchase.where( :id => params[:id]).includes( :basket => {:items => {:product => :supplier}} ).first
  end

  def params_for_model
    params.require(:purchase).permit(:name,:ordered_on,:received_on,:basket_id)
  end
end

