class SessionsController < ApplicationController
  layout "ruby_clerks"
  def sign_in
  end

  def create
    clerk = Clerk.where(:email => params[:email]).limit(1).first
    if clerk && clerk.valid_password?(params[:password])
      session[:clerk_email] = clerk.email
      if clerk.admin
        redirect_to orders_url , :notice => I18n.t(:signed_in)
      else
        redirect_after_sign_up
      end
    else
      redirect_to sign_in_url , :notice => I18n.t(:sign_in_invalid)
    end
  end

  def sign_out
    session[:clerk_email] = nil
    redirect_to sign_in_url , :notice => I18n.t(:signed_out)
  end

  def sign_up
    if request.get?
      @clerk = Clerk.new
    else
      redirect_to sign_in_url , :notice => "No sign ups"
      begin
        @clerk = Clerk.new(params_for_clerk)
        if @clerk.save
          session[:clerk_email] = @clerk.email
          return redirect_after_sign_up
        end
      rescue #this is just needed for hackers, so we don't get rollbar events
        @clerk = Clerk.new
      end
    end
  end

  private

  def redirect_after_sign_up
    redirect_to root_url, :notice => t(:signed_up)
  end

  def redirect_after_sign_in
    redirect_to root_url, :notice => t(:signed_in)
  end
  def params_for_clerk
    params.require(:clerk).permit(:email,:password,:password_confirmation)
  end

end
