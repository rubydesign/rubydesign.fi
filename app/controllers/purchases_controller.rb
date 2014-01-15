# encoding : utf-8
class PurchasesController < AdminController

  before_filter :load_purchase, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index    
    @q = Purchase.search params[:q]

    @purchase_scope = @q.result(:distinct => true)
    
    @purchase_scope_for_scope = @purchase_scope.dup
    
    unless params[:scope].blank?
      @purchase_scope = @purchase_scope.send(params[:scope])
    end
    
    @purchases = @purchase_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @purchase_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Purchase.attribute_names
          @purchase_scope.to_a.each{ |o|
            csv << Purchase.attribute_names.map{ |a| o[a] }
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
      format.json { render :json => @purchase }
    end
  end

  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @purchase }
    end
  end

  def edit
    
  end

  def create
    @purchase = Purchase.create(params_for_model)

    respond_to do |format|
      if @purchase.save
        format.html {
          redirect_to purchase_path(@purchase), :flash => { :notice => t(:create_success, :model => "purchase") }
        }
        format.json { render :json => @purchase, :status => :created, :location => @purchase }
      else
        format.html {
          render :action => "new"
        }
        format.json { render :json => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @purchase.update_attributes(params_for_model)
        format.html { redirect_to purchase_path(@purchase), :flash => { :notice => t(:update_success, :model => "purchase") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :ok }
    end
  end

  private 
  
  def load_purchase
    @purchase = Purchase.find(params[:id])
  end

  def params_for_model
    params.require(:purchase).permit(Purchase.permitted_attributes)
  end
end

