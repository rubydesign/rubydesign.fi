# encoding : utf-8

class ProductsController < AdminController
  include ProductsHelper
  include Barcode

  before_action :load_product, :only => [:show, :edit, :update, :destroy ]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    param = params[:q] || {}
    param.merge!(:product_id_null => 1)    unless( params[:basket])
    @q = Product.search( param )
    @product_scope = @q.result(:distinct => true).includes(:products , :supplier , :category)
    @products = @product_scope.page(params[:page])
    create_used_inventory_list if( available_inventory )
  end

  def show
  end

  def new
    if params[:parent_id]
      parent = Product.find params[:parent_id]
      @product = parent.new_product_item
    else
      @product = Product.new :tax => RubyClerks.config("defaults.tax")
    end
    render :edit
  end

  def edit
  end

  def create
    @product = Product.create(params_for_model)
    if @product.save
      flash.notice = t(:create_success, :model => "product")
      show = @product.product_item? ? @product.product : @product
      redirect_to product_path(show)
    else
      flash.alert = t(:fix_errors, :model => "product")
      render :action => :edit
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params_for_model)
        format.html { redirect_to(@product, :notice => t(:update_success, :model => "product")) }
        format.json { respond_with_bip(@product) }
      else
        format.html { render :action => :edit }
        format.json { respond_with_bip(@product) }
      end
    end
  end

  def destroy
    @product.delete
    if @product.save
      redirect_to products_url , :notice => t("deleted") + ": " + @product.full_name
    else
      redirect_to product_url(@product) , :notice => "#{t(:error)} : #{t(:product_has_inventory)}"
    end
  end

  private

  def create_used_inventory_list
    order_ids = Order.where("created_at > ?" , 1.month.ago ).pluck(:id)
    basket_ids = Basket.where(kori_id: order_ids).where(locked: nil).pluck(:id)
    @product_inventory = Hash.new(0)
    for_products = available_inventory ? @product_scope : @products
    product_ids = for_products.each {|p| p.id }
    Item.where(basket_id: basket_ids).where(product_id: product_ids).each do |item|
      @product_inventory[item.product_id] = @product_inventory[item.product_id] + item.quantity
    end
  end

  def load_product
    @product = Product.find(params[:id])
  end

  def params_for_model
    params.require(:product).permit(:price,:cost,:weight,:name,:description, :online, :summary,
                                    :stock_level,:link,:ean,:tax,:properties,:scode,:product_id,
                                    :category_id,:supplier_id, :main_picture, :position, :pack_unit)
  end
end
