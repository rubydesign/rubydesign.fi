class HousesController < AdminController

  before_action :load_basket, :only => [ :edit, :update]

  def index
    @q = Basket.where.not(kind: nil).ransack( params[:q] )
    @house_scope = @q.result( :distinct => true )
    @houses = @house_scope.includes(:kori).page(params[:page] )
  end

  def new
    house = Basket.create! kind: "house"
    redirect_to edit_house_path(house)
  end

  def show
    raise "not implemented"
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

  protected

  def create_data
    @products = Product.where(supplier_id: self.class.ecoframe).includes(:category , [:category , :category])
  end

  private

  def load_basket
    @basket = Basket.find(params[:id])
  end

end
