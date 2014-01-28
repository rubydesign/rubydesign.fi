class SessionsController < ApplicationController
  layout "shop"

  def new
  end

  def create
    clerk = Clerk.where(:email => params[:email]).limit(1).first
    if clerk && clerk.valid_password?(params[:password])
      session[:clerk_email] = clerk.email
      url = clerk.admin ?  baskets_url : root_url
      redirect_to url , :notice => I18n.t(:signed_in)
    else
      flash.notice = I18n.t(:sign_in_invalid)
      render "new"
    end
  end

  def destroy
    session[:clerk_email] = nil
    redirect_to root_url, :notice => I18n.t(:signed_out)
  end

  def new_clerk
    @clerk = Clerk.new
  end

  def update_clerk
    @clerk = current_clerk
    if @clerk.update_attributes(params[:clerk])
      redirect_to root_url, :notice => I18n.t(:updated)
    else
      render :action => 'edit'
    end
  end
  
  def create_clerk
    @clerk = Clerk.new(params[:clerk])
    if @clerk.save
      session[:clerk_email] = @clerk.email
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
end
