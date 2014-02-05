require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should redirect when authentication is valid" do
    Clerk.any_instance.stub(:valid_password?).and_return(true)
    email = Clerk.where(:admin=>false).first.email
    post :create , :email => email
    response.should redirect_to(root_url)
    session['clerk_email'].should == email
  end
end
