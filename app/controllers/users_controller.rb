# encoding : utf-8
class UsersController < AdminController

  before_filter :load_user, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    @q = User.search params[:q]
    @user_scope = @q.result(:distinct => true)
    @users = @user_scope.paginate( :page => params[:page],:per_page => 20).to_a
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit    
  end

  def create
    @user = User.create(params_for_model)
    if @user.save
      redirect_to user_path(@user), :flash => { :notice => t(:create_success, :model => "user") }
    else
      render :action => "new"
    end
  end

  def update
    pars = params_for_model
    if pars["password"].blank? and pars["password_confirmation"].blank?
      pars.delete("password")
      pars.delete("password_confirmation")
    end
    if @user.update_attributes(pars)
      redirect_to user_path(@user), :flash => { :notice => t(:update_success, :model => "user") }
    else
      render :action => "edit" 
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url 
  end

  private 
  
  def load_user
    @user = User.find(params[:id])
  end

  def params_for_model
    params.require(:user).permit( :email,:name , :street , :city , :phone ,:password, :password_confirmation)
  end
end

