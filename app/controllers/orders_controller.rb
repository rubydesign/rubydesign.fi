# encoding : utf-8
class OrdersController < AdminController

  before_filter :load_order, :only => [:show, :edit, :update , :pay ,:ship, :shipment , :mail]

  def index
    @q = Order.search(params[:q])
    @order_scope = @q.result( :distinct => true)
    @orders = @order_scope.includes(:basket => :items ).paginate(:page => params[:page],:per_page => 20)
  end

  def show
    gon.order_id = @order.id
  end

  def new
    @order = Order.new
    @order.build_basket
    render :edit
  end

  def mail
    action = params[:act]
    mail = eval("OrderMailer.#{action}(@order)")
    mail.deliver
    flash.notice = "Sent #{action}"
    redirect_to :action => :show
  end
  def pay
    @order.pay_now
    @order.save
    render :show
  end

  def ship
    @order.ship_now
    @order.basket.deduct!
    @order.save!
    render :show
  end

  def shipment
    return if request.get?
    return redirect_to order_path(@order), :notice => t(:update_success) if @order.update_attributes(params_for_order)
  end
  
  def edit
  end

  def create
    @order = Order.create(params_for_order)
    @order.build_basket() unless @order.basket
    if @order.save
      redirect_to order_path(@order), :notice => t(:create_success, :model => :order)
    else
      render :edit
    end
  end

  def update
    @order.build_basket unless @order.basket
    respond_to do |format|
      if @order.update_attributes(params_for_order)
        format.html { redirect_to(@order, :notice => t(:update_success, :model => :order)) }
        format.json { respond_with_bip(@order) }
      else
        format.html { render :action => :edit }
        format.json { respond_with_bip(@order) }
      end
    end
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end

  def params_for_order
    params.require(:order).permit(:shipment_price,:shipment_tax,:shipment_type, :note)
  end
end

