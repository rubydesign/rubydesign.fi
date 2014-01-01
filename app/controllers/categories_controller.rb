# encoding : utf-8
class CategoriesController < BeautifulController

  before_filter :load_category, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    do_sort_and_paginate(:category)
    
    @q = Category.search(
      params[:q]
    )

    @category_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @category_scope_for_scope = @category_scope.dup
    
    unless params[:scope].blank?
      @category_scope = @category_scope.send(params[:scope])
    end
    
    @categories = @category_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @category_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Category.attribute_names
          @category_scope.to_a.each{ |o|
            csv << Category.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @category }
    end
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @category }
    end
  end

  def edit
    
  end

  def create
    @category = Category.create(params_for_model)

    respond_to do |format|
      if @category.save
        format.html {
          redirect_to category_path(@category), :flash => { :notice => t(:create_success, :model => "category") }
        }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @category.update_attributes(params_for_model)
        format.html { redirect_to category_path(@category), :flash => { :notice => t(:update_success, :model => "category") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @categories = []    
    
    Category.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:category)

        @categories = Category.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @categories = Category.find(params[:ids].to_a)
      end

      @categories.each{ |category|
        if not Category.columns_hash[attr_or_method].nil? and
               Category.columns_hash[attr_or_method].type == :boolean then
         category.update_attribute(attr_or_method, boolean(value))
         category.save
        else
          case attr_or_method
          # Set here your own batch processing
          # category.save
          when "destroy" then
            category.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  private 
  
  def load_category
    @category = Category.find(params[:id])
  end

  def params_for_model
    params.require(:category).permit(:category_id,:name,:link,:main_picture,:extra_picture)
  end
end

