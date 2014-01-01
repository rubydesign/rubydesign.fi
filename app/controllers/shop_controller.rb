class ShopController < ApplicationController
  before_action :load

  layout "shop"

  
  def product
    @product = Product.where(:link => params[:id]).first
    #error handling
#    @group = Category.find(@product.category_id)
  end

  def group
    @group = Category.where(:link => params[:id])
  end

  private
    def load
      @groups = Category.all
      @menu =  {"/pages/kotisivu" => "KOTISIVU" ,
                "/products" => "VERKKOKAUPPA" ,
                "/pages/tuotteista" => "TUOTTEISTA",
                "/pages/toimitusehdot" => "TOIMITUSEHDOT" ,
                "/pages/liike" => "LIIKKEEMME" }
      @groups =  { "Luomukosmetiikka" =>["Kasvojenhoito" , "Vartalonhoito" , "Hiustenhoito" , "Aromasprayt"],
                  "Sisustus" => ["Valaisimet" , "Gourmet" , "Vaatteet","Muut"] }
    end
end
