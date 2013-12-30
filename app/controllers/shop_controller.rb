class ShopController < ApplicationController
  before_action :load

  layout "shop"

  
  def product
    @product = Product.where(:url_name => params[:id]).first
    #error handling
    @group = ProductGroup.find(@product.product_group_id)
  end

  def group
    @group = ProductGroup.where(:url_name => params[:id])
  end

  private
    def load
      @groups = ProductGroup.all
      @menu =  {"/pages/kotisivu" => "KOTISIVU" ,
                "/products" => "VERKKOKAUPPA" ,
                "/pages/tuotteista" => "TUOTTEISTA",
                "/pages/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/pages/liike" => "LIIKKEEMME" }
      @groups =  { "Luomukosmetiikka" =>["Kasvojenhoito" , "Vartalonhoito" , "Hiustenhoito" , "Aromasprayt"],
                  "Sisustus" => ["Valaisimet" , "Gourmet" , "Vaatteet","Muut"] }
    end
end
