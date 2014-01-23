# encoding : utf-8
class PurchasesController < AdminController

  before_filter :load_purchase, :only => [:show, :edit, :update, :destroy , :order , :receive , :inventory]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Purchase.search params[:q]
    @purchase_scope = @q.result(:distinct => true)
    @purchases = @purchase_scope.paginate( :page => params[:page],:per_page => 20 ).to_a
  end

  def show
  end

  # order this from supplier
  def order
    @purchase.order!
    redirect_to purchase_path(@purchase), :flash => { :notice => t(:ordered) }
  end

  # receive the stuff (ie add to inventory)
  def receive
    items = @purchase.receive!
    redirect_to purchase_path(@purchase), :flash => { :notice => [t(:received) ,items ,t(:items)].join(" ") }
  end

  # receive the stuff (ie add to inventory)
  def inventory
    items = @purchase.inventory!
    redirect_to purchase_path(@purchase), :flash => { :notice => [t(:inventorized) ,items ,t(:items)].join(" ") }
  end

  def new
    @purchase = Purchase.new
  end

  def edit

  end

  def create
    @purchase = Purchase.create(params_for_model)
    if @purchase.save
      redirect_to purchase_path(@purchase), :flash => { :notice => t(:create_success, :model => "purchase") }
    else
      render :action => "new"
    end
  end

  def update
    if @purchase.update_attributes(params_for_model)
      redirect_to purchase_path(@purchase), :flash => { :notice => t(:update_success, :model => "purchase") }
    else
      render :action => "edit"
    end
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_url
  end

  private

  def load_purchase
    @purchase = Purchase.find(params[:id])
  end

  def params_for_model
    params.require(:purchase).permit(:name,:ordered_on,:received_on,:basket_id)
  end
end

