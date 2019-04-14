# encoding : utf-8

# A Supplier spupplies inventory for products.
# The object itself only has an address, it's main function is to be the owner of purchase orders
# In other words the supplier is to the Purchase what the User is to an order.
#
class SuppliersController < AdminController

  before_action :load_supplier, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  # authorize_resource

  def index
    @q = Supplier.ransack(params[:q])
    @supplier_scope = @q.result(:distinct => true)
    @suppliers = @supplier_scope.page(params[:page])
  end

  def show
  end

  def new
    @supplier = Supplier.new
    render :edit
  end

  def edit
  end

  def create
    @supplier = Supplier.create(params_for_supplier)
    if @supplier.save
      redirect_to supplier_path(@supplier), :notice => t(:create_success, :model => :supplier)
    else
      render :edit
    end
  end

  def update
    @supplier.update_attributes params_for_supplier
    if @supplier.save
      redirect_to supplier_path(@supplier), :notice => t(:update_success, :model => :supplier)
    else
      render :action => :edit
    end
  end

  def destroy
    if( @supplier.products.empty? )
      @supplier.delete.save
      redirect_to suppliers_path , :notice => t(:deleted) + ": " + @supplier.supplier_name
    else
      redirect_to supplier_path(@category) , :notice => "#{t(:error)} : #{t(:supplier_not_empty)}"
    end
  end

  private

  def load_supplier
    @supplier = Supplier.find(params[:id])
  end

  def params_for_supplier
    params.require(:supplier).permit(:supplier_name,:address)
  end
end
