class SessionsController < ApplicationController
  layout "shop"

  def new
  end

  def create
    user = User.where(:email => params[:email]).limit(1).first
    if user && user.valid_password?(params[:password])
      session[:user_email] = user.email
      url = user.admin ?  baskets_url : root_url
      redirect_to url , :notice => I18n.t(:signed_in)
    else
      flash.notice = I18n.t(:sign_in_invalid)
      render "new"
    end
  end

  def destroy
    session[:user_email] = nil
    redirect_to root_url, :notice => I18n.t(:signed_out)
  end

  def new_user
    @user = User.new
  end

  def update_user
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => I18n.t(:updated)
    else
      render :action => 'edit'
    end
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      session[:user_email] = @user.email
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
end
