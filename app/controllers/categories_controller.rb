# encoding : utf-8
class CategoriesController < AdminController

  before_action :load_category, :only => [ :edit, :show, :update, :destroy]

  def index
    @q = Category.ransack(params[:q])
    @category_scope = @q.result(:distinct => true)
    @categories = @category_scope.includes(:products , :categories ).page( params[:page])
    @roots = Category.where(:category_id => nil).includes(:products , :categories ).to_a
  end

  def new
    if(id = params[:copy])
      sama = Category.find(id)
      @category = Category.new(name: "#{sama.name} copy" , category_id: sama.category_id)
    else
      @category = Category.new
    end
    render :edit
  end

  def edit

  end

  def create
    @category = Category.create(params_for_model)
    if @category.save
      flash.notice = t(:create_success, :model => "category")
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def update
    if @category.update_attributes(params_for_model)
      notice = t(:update_success, :model => "category")
      redirect_to category_path(@category),  :notice => notice
    else
      render :action => :edit
    end
  end

  def destroy
    if( @category.products.empty?  || @category.categories.empty? )
      @category.delete.save
      redirect_to categories_url , :notice => t(:deleted) + ": " + @category.name
    else
      redirect_to category_url(@category) , :notice => "#{t(:error)} : #{t(:category_not_empty)}"
    end
  end

  private

  def load_category
    @category = Category.where(:id => params[:id]).includes(:products).first
  end

  def params_for_model
    params.require(:category).permit(:category_id,:name,:position,
                                    :summary, :description)
  end
end
