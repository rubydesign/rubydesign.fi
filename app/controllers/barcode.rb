# coding: UTF-8
require 'barby'
require 'prawn'
require 'prawn/measurement_extensions'
require 'barby/barcode/code_128'
require 'barby/barcode/ean_13'
require 'barby/outputter/png_outputter'

module Barcode
  # loads of ways to create barcodes nowadays, this is a bit older.
  # Used to be html but moved to pdf for better layout control
  def barcode
    load_product
    code = @product.ean
    code = @product.name if code.blank?
    if code.length == 12
      aBarcode =  ::Barby::EAN13.new( code )
    else
      puts "Barcode utf   #{code}"
      code = code.encode(Encoding::ASCII_8BIT, :invalid => :replace, :undef => :replace, :replace => '')
      puts "Barcode ascii #{code}"
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

end
