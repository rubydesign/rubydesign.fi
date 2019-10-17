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

  end

  private
  def load_basket
    @basket = Basket.find(params[:id])
  end

  def params_for_basket
    return {} if params[:basket].blank? or params[:basket].empty?
    params.require(:basket).permit( :items_attributes => [:quantity ,:name, :price , :id, :product_id] )
  end
end
