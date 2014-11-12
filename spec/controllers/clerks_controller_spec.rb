require 'spec_helper'

describe ClerksController do
  routes { OfficeClerk::Engine.routes }

  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  it "new action should render new template" do
    get :new
#gets redirected    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    allow_any_instance_of(Clerk).to receive(:valid?).and_return(false)
    post :create
#gets redirected    response.should render_template("new")
  end

  it "create action should redirect when model is valid" do
    allow_any_instance_of(Clerk).to receive(:valid?).and_return(true)
    post :create
    expect(response).to redirect_to(sign_in_path)
#    session['clerk_email'].should == assigns['clerk'].email
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    expect(response).to redirect_to(sign_in_path)
  end

  it "edit action should render edit template" do
    allow(@controller).to receive(:current_clerk).and_return(Clerk.first)
#    get :edit, :id => "ignored"
#    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    expect(response).to redirect_to(sign_in_path)
  end

#  it "update action should render edit template when clerk is invalid" do
#    @controller.stub(:current_clerk).and_return(Clerk.first)
#    Clerk.any_instance.stub(:valid?).and_return(false)
#    put :update_clerk, :id => "ignored"
#    response.should render_template(:edit)
#  end

#  it "update action should redirect when clerk is valid" do
#    @controller.stub(:current_clerk).and_return(Clerk.first)
#    Clerk.any_instance.stub(:valid?).and_return(true)
#    put :update_clerk, :id => "ignored"
#    response.should redirect_to(root_path)
#  end

  describe "GET 'show'" do
    it "should be successful" do
      clerk = create :clerk
      sign_in
      visit_path clerk_path(clerk)
    end
  end

end
