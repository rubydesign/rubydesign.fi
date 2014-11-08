# encoding : utf-8
class CategoriesController < AdminController

  before_filter :load_category, :only => [ :edit, :update, :destroy]

  def index
    @q = Category.search(params[:q])
    @category_scope = @q.result(:distinct => true)
    @categories = @category_scope.includes(:products , :categories ).paginate( :page => params[:page],:per_page => 20).to_a
    @roots = Category.where(:category_id => nil).includes(:products , :categories ).to_a
  end

  def show
    @category = Category.where(:id => params[:id]).includes(:products).first
  end

  def new
    @category = Category.new
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
    online = @category.online
    if @category.update_attributes(params_for_model)
      notice = t(:update_success, :model => "category")
      if @category.online != online
        count = 0
        @category.products.each do |prod|
          prod.online = @category.online
          prod.save
          count += 1
        end
        notice += "<br> #{count} " + t(:products) + " " + (@category.online ? t(:made_online) : t(:made_offline))
      end
      redirect_to category_path(@category),  :notice => notice 
    else
      render :action => :edit 
    end
  end

  def destroy
    @category.destroy if @category.categories.empty?
    redirect_to categories_url 
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def params_for_model
    params.require(:category).permit(:category_id,:name,:link,:main_picture,:extra_picture,:position, :online, :description)
  end
end

