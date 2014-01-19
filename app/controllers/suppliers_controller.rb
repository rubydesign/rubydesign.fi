# encoding : utf-8
class SuppliersController < AdminController

  before_filter :load_supplier, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Supplier.search( params[:q] )
    @supplier_scope = @q.result( :distinct => true )
    @supplier_scope_for_scope = @supplier_scope.dup
    unless params[:scope].blank?
      @supplier_scope = @supplier_scope.send(params[:scope])
    end
    @suppliers = @supplier_scope.paginate( :page => params[:page], :per_page => 20 ).to_a
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def edit
  end

  def create
    @supplier = Supplier.create(params_for_supplier)
    if @supplier.save
      redirect_to supplier_path(@supplier), :flash => { :notice => t(:create_success, :model => "supplier") }
    else
      render :action => "new"
    end
  end

  def update
    @supplier.update_attributes params_for_supplier
    if @supplier.save
      redirect_to supplier_path(@supplier), :flash => { :notice => t(:update_success, :model => "supplier") }
    else
      render :action => "edit"
    end
  end

  def destroy
#    @supplier.deleted_at = Time.now
    redirect_to suppliers_url 
  end

  private 
  
  def load_supplier
    @supplier = Supplier.find(params[:id])
  end

  def params_for_supplier
    params.require(:supplier).permit!
  end
end

