# encoding : utf-8
class OrdersController < AdminController

  before_filter :load_order, :only => [:show, :edit, :update, :destroy , :print]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Order.search(params[:q])
    @order_scope = @q.result( :distinct => true)
    @order_scope_for_scope = @order_scope.dup
    
    unless params[:scope].blank?
      @order_scope = @order_scope.send(params[:scope])
    end
    
    @orders = @order_scope.paginate(:page => params[:page],:per_page => 20).to_a

  end

  def show
  end

  def print
    template = params[:template] || "receipt"
    eval "@#{template} = true"
    render  template , :layout => false
  end
  
  def new
    @order = Order.new
    @order.build_basket 
  end

  def edit
    
  end

  def create
    @order = Order.create(params_for_model)
    @order.build_basket() unless @order.basket
    if @order.save
      redirect_to order_path(@order), :flash => { :notice => t(:create_success, :model => "order") }
    else
      render :action => "new"
    end
  end

  def update
    @order.build_basket unless @order.basket
    if @order.update_attributes(params_for_model)
      redirect_to order_path(@order), :flash => { :notice => t(:update_success, :model => "order") }
    else
      render :action => "edit" 
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url
  end

  private 
  
  def load_order
    @order = Order.find(params[:id])
  end

  def params_for_model
    params.require(:order).permit(:ordered_on,:shipping_price,:shipping_tax,:basket_id,:email,:paid_on,:shipped_on,:paid_on,:canceled_on,:shipment_type)
  end
end

