# encoding : utf-8
class ProductGroupsController < BeautifulController

  before_filter :load_product_group, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:product_group] ||= (ProductGroup.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:product_group)
    do_sort_and_paginate(:product_group)
    
    @q = ProductGroup.search(
      params[:q]
    )

    @product_group_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @product_group_scope_for_scope = @product_group_scope.dup
    
    unless params[:scope].blank?
      @product_group_scope = @product_group_scope.send(params[:scope])
    end
    
    @product_groups = @product_group_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @product_group_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << ProductGroup.attribute_names
          @product_group_scope.to_a.each{ |o|
            csv << ProductGroup.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @product_group_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(ProductGroup,@product_group_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @product_group }
    end
  end

  def new
    @product_group = ProductGroup.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @product_group }
    end
  end

  def edit
    
  end

  def create
    @product_group = ProductGroup.create(params_for_model)

    respond_to do |format|
      if @product_group.save
        format.html {
          redirect_to product_group_path(@product_group), :flash => { :notice => t(:create_success, :model => "product_group") }
        }
        format.json { render :json => @product_group, :status => :created, :location => @product_group }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @product_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @product_group.update_attributes(params_for_model)
        format.html { redirect_to product_group_path(@product_group), :flash => { :notice => t(:update_success, :model => "product_group") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_group.destroy

    respond_to do |format|
      format.html { redirect_to product_groups_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @product_groups = []    
    
    ProductGroup.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:product_group)

        @product_groups = ProductGroup.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @product_groups = ProductGroup.find(params[:ids].to_a)
      end

      @product_groups.each{ |product_group|
        if not ProductGroup.columns_hash[attr_or_method].nil? and
               ProductGroup.columns_hash[attr_or_method].type == :boolean then
         product_group.update_attribute(attr_or_method, boolean(value))
         product_group.save
        else
          case attr_or_method
          # Set here your own batch processing
          # product_group.save
          when "destroy" then
            product_group.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = ProductGroup
    foreignkey = :product_group_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_product_group
    @product_group = ProductGroup.find(params[:id])
  end

  def params_for_model
    params.require(:product_group).permit(ProductGroup.permitted_attributes)
  end
end

