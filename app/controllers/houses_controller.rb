class HousesController < AdminController

  before_action :load_basket, :only => [ :edit, :update]

  def index
    @q = Basket.where.not(kind: nil).ransack( params[:q] )
    @house_scope = @q.result( :distinct => true )
    @houses = @house_scope.includes(:kori).page(params[:page] )
  end

  def products
    products = create_data
    updated = 0
    products.each { |p| updated += p.update_price(true) }
    flash.notice = t(:update_success, :model => "product")  + "  #{updated}"
    redirect_to houses_path
  end

  def new
    house = Basket.create! kind: "house" , width: 8 , length: 12 , height: 3.3 , angle: 30
    redirect_to edit_house_path(house)
  end

  def update
    house_params = params.require(:basket).permit( :width , :length , :height , :angel)
    if @basket.update_attributes(house_params)
      flash.notice = t(:update_success, :model => "basket")
      update_quantities
    else
      flash.notice = t(:update_failed, :model => "basket")
    end
    redirect_to edit_house_path(@basket)
  end

  def update_quantities
    @basket.items.each do |item|
      quantity = item.product.amount_for(@basket)
      next unless quantity
      next if quantity == "error"
      next if item.quantity == quantity
      item.quantity = quantity
      item.save!
    end
  end

  def edit
    if( @basket.locked?)
      redirect_to basket_path(@basket) , notice: "Cant edit, locked"
    end
    create_data
  end

  def self.ecoframe
    return @ecoframe if @ecoframe
    @ecoframe = Supplier.where(supplier_name: "EcoFrameHouse").first.id
  end
  def self.materials
    return @materials if @materials
    @materials = Category.where(name: "Materials").first.id
  end

  private

  def create_data
    @products = Product.where(supplier_id: self.class.ecoframe).
                        where.not(category_id: self.class.materials).
                        includes(:category , [:category , :category])
  end


  def load_basket
    @basket = Basket.find(params[:id])
  end

end
