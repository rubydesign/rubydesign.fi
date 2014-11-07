# encoding : utf-8
require 'barby'
require 'prawn'
require 'prawn/measurement_extensions'
require 'barby/barcode/code_128'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'

class ProductsController < AdminController

  before_filter :load_product, :only => [:show, :edit, :update, :delete , :barcode]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    param = params[:q] || {}
    param.merge!(:product_id_null => 1)    unless( params[:basket])
    @q = Product.search( param )
    @product_scope = @q.result(:distinct => true)
    @products = @product_scope.includes(:products , :supplier , :category).paginate( :page => params[:page], :per_page => 20 ).to_a
  end

  def show
  end

  def new
    if params[:parent_id]
      parent = Product.find params[:parent_id]
      @product = parent.new_product_item
    else
      @product = Product.new :tax => OfficeClerk.config("defaults.tax")
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
      render :action => :edit
    end
  end

  def update
    if @product.update_attributes(params_for_model)
      flash.notice = t(:update_success, :model => "product")
      redirect_to product_path(@product)
    else
      render :action => :edit
    end
  end

  def delete
    @product.delete
    if @product.save
      redirect_to products_url , :notice => t("deleted")
    else
      redirect_to product_url , :notice => "#{t(:error)} : #{t(:inventory)}"
    end
  end
  
  # loads of ways to create barcodes nowadays, this is a bit older. 
  # Used to be html but moved to pdf for better layout control
  def barcode
    code = @product.ean.blank? || ""
    if code.length == 12
      aBarcode =  ::Barby::EAN13.new( code )
    else
      aBarcode = ::Barby::Code128B.new( code  )
    end
    pdf = create_pdf
    pdf.image( StringIO.new( aBarcode.to_png(:xdim => 5)) , :width => 50.mm , 
            :height => 10.mm , :at => [ 0 , 10.mm])
    send_data pdf.render , :type => "application/pdf" , :filename => "#{@product.full_name}.pdf"
  end
  
  private

  def create_pdf
    pdf = Prawn::Document.new( :page_size => [ 54.mm , 25.mm ] , :margin => 2.mm )
    pdf.text( @product.full_name  , :align => :left )
    pdf.text( "#{@product.price} € "  , :align => :right , :padding => 5.mm)
    pdf
  end

  def load_product
    @product = Product.find(params[:id])
  end

  def params_for_model
    params.require(:product).permit(:price,:cost,:weight,:name,:description, :online,
      :link,:ean,:tax,:properties,:scode,:product_id,:category_id,:supplier_id, :main_picture,:extra_picture
)
  end
end

