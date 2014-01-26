class SessionsController < ApplicationController
  layout "shop"

  def new
  end

  def create
    user = User.where(:email => params[:email]).limit(1).first
    if user && user.valid_password?(params[:password])
      session[:user_id] = user.id
      url = user.admin ?  baskets_url : root_url
      redirect_to url , :notice => "Logged in!"
    else
      flash.notice = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def new_user
    @user = User.new
  end

  def update_user
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
end
