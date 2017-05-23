# encoding : utf-8
class ClerksController < AdminController

  before_action :load_clerk, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = Clerk.search params[:q]
    @clerk_scope = @q.result(:distinct => true)
    @clerks = @clerk_scope.paginate( :page => params[:page],:per_page => 20)
  end

  def show
  end

  def new
    @clerk = Clerk.new
    render :edit
  end

  def edit
  end

  def create
    @clerk = Clerk.create(params_for_model)
    if @clerk.save
      flash.notice = t(:create_success, :model => "clerk") 
      redirect_to clerk_path(@clerk)
    else
      render :edit
    end
  end

  def update
    pars = params_for_model
    if pars["password"].blank? and pars["password_confirmation"].blank?
      pars.delete("password")
      pars.delete("password_confirmation")
    end
    if @clerk.update_attributes(pars)
      redirect_to clerk_path(@clerk),  :notice => t(:update_success, :model => "clerk")
    else
      render :action => :edit
    end
  end

  private

  def load_clerk
    @clerk = Clerk.find(params[:id])
  end

  def params_for_model
    params.require(:clerk).permit( :email,:name , :street , :city , :phone ,:password, :password_confirmation , :admin)
  end
end

