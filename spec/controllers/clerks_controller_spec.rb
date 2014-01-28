require 'spec_helper'

describe ClerksController do

  before (:each) do
    @clerk = create(:clerk)
    sign_in @clerk
  end

  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Clerk.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Clerk.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
    session['clerk_id'].should == assigns['clerk'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_clerk).returns(Clerk.first)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when clerk is invalid" do
    @controller.stubs(:current_clerk).returns(Clerk.first)
    Clerk.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when clerk is valid" do
    @controller.stubs(:current_clerk).returns(Clerk.first)
    Clerk.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end

  describe "GET 'show'" do

    it "should be successful" do
      get :show, :id => @clerk.id
      response.should be_success
    end

    it "should find the right clerk" do
      get :show, :id => @clerk.id
      assigns(:clerk).should == @clerk
    end

  end

end
