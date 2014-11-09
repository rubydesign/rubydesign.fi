require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do

  it "new action should render new template" do
    get :sign_in
    expect(response).to render_template(:sign_in)
  end

  it "create action should redirect to root for user if authentication is valid" do
    allow_any_instance_of(Clerk).to receive(:valid_password?).and_return(true)
    clerk = create :clerk
    email = Clerk.where(:admin=>false).first.email
    post :create , :email => email
    expect(response).to redirect_to(root_path)
    expect(session['clerk_email']).to eq email
  end
  it "create action should redirect to baskets for admin if authentication is valid" do
    allow_any_instance_of(Clerk).to receive(:valid_password?).and_return(true)
    clerk = create :admin
    email = Clerk.where(:admin=>true).first.email
    post :create , :email => email
    expect(response).to redirect_to(baskets_path)
    expect(session['clerk_email']).to eq email
  end
end
