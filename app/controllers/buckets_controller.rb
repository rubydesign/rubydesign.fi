# encoding : utf-8
class BucketsController < BeautifulController

  before_filter :load_bucket, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:bucket] ||= (Bucket.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:bucket)
    do_sort_and_paginate(:bucket)
    
    @q = Bucket.search(
      params[:q]
    )

    @bucket_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @bucket_scope_for_scope = @bucket_scope.dup
    
    unless params[:scope].blank?
      @bucket_scope = @bucket_scope.send(params[:scope])
    end
    
    @buckets = @bucket_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @bucket_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Bucket.attribute_names
          @bucket_scope.to_a.each{ |o|
            csv << Bucket.attribute_names.map{ |a| o[a] }
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
      format.json { render :json => @bucket }
    end
  end

  def new
    @bucket = Bucket.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @bucket }
    end
  end

  def edit
    
  end

  def create
    @bucket = Bucket.create(params_for_model)

    respond_to do |format|
      if @bucket.save
        format.html {
          redirect_to bucket_path(@bucket), :flash => { :notice => t(:create_success, :model => "bucket") }
        }
        format.json { render :json => @bucket, :status => :created, :location => @bucket }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @bucket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @bucket.update_attributes(params_for_model)
        format.html { redirect_to bucket_path(@bucket), :flash => { :notice => t(:update_success, :model => "bucket") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bucket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bucket.destroy

    respond_to do |format|
      format.html { redirect_to buckets_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @buckets = []    
    
    Bucket.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:bucket)

        @buckets = Bucket.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @buckets = Bucket.find(params[:ids].to_a)
      end

      @buckets.each{ |bucket|
        if not Bucket.columns_hash[attr_or_method].nil? and
               Bucket.columns_hash[attr_or_method].type == :boolean then
         bucket.update_attribute(attr_or_method, boolean(value))
         bucket.save
        else
          case attr_or_method
          # Set here your own batch processing
          # bucket.save
          when "destroy" then
            bucket.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Bucket
    foreignkey = :bucket_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_bucket
    @bucket = Bucket.find(params[:id])
  end

  def params_for_model
    params.require(:bucket).permit(Bucket.permitted_attributes)
  end
end

