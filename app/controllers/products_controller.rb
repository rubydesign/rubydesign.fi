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
    @product_scope_for_scope = @product_scope.dup
    unless params[:scope].blank?
      @product_scope = @product_scope.send(params[:scope])
    end
    @products = @product_scope.paginate( :page => params[:page], :per_page => 20 ).to_a
  end

  def show
  end

  def new
    @product = Product.new
    @product.product_id = params[:parent_id] if params[:parent_id]
  end

  def edit
  end

  def create
    @product = Product.create(params_for_model)
    if @product.save
      redirect_to product_path(@product), :flash => { :notice => t(:create_success, :model => "product") }
    else
      render :action => "new"
    end
  end

  def update
    if @product.update_attributes(params_for_model)
      redirect_to product_path(@product), :flash => { :notice => t(:update_success, :model => "product") }
    else
      render :action => "edit"
    end
  end

  def delete
    @product.delete
    if @product.save
      redirect_to products_url , :flash => {:notice => "deleted"}
    else
      redirect_to products_url , :flash => {:notice => "error"}
    end
  end
  
  # loads of ways to create barcodes nowadays, this is a bit older. 
  # Used to be html but moved to pdf for better layout control
  def barcode
    pdf = Prawn::Document.new( :page_size => [ 54.mm , 25.mm ] , :margin => 1.mm )
    name = @product.full_name
    pdf.text( name )
    price = @product.price 
    pdf.text( "#{price} €"  , :align => :right )
    if barcode = barcode_pdf
      pdf.image( StringIO.new( barcode.to_png(:xdim => 5)) , :width => 50.mm , 
            :height => 10.mm , :at => [ 0 , 10.mm])
    end
    send_data pdf.render , :type => "application/pdf" , :filename => "#{name}.pdf"
  end
  
  private

  #get the barby barcode object from the id, or nil if something goes wrong
  def barcode_pdf
    code = nil
    code = @product.ean
    code = @product.scode if code.blank?
    return nil if code.blank?
    if code.length == 12
      return ::Barby::EAN13.new( code )
    else
      return ::Barby::Code128B.new( code  )
    end
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

