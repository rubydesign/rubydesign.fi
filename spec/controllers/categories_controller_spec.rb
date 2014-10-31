require 'spec_helper'

describe CategoriesController do

  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  

 # This should return the minimal set of values that should be in the session
 # in order to pass any filters (e.g. authentication) defined in
 # SuppliersController. Be sure to keep this updated too.
 let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = create :category
      get :index, {}, valid_session
#      assigns(:categories).to eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = create :category
      get :show, {:id => category.to_param}, valid_session
      assigns(:category).to eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      assigns(:category).to be _a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      category = create :category
      get :edit, {:id => category.to_param}, valid_session
      assigns(:category).to eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category =>  attributes_for(:category)}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category =>  attributes_for(:category)}, valid_session
        assigns(:category).to be _a(Category)
        assigns(:category).to be _persisted
      end

      it "redirects to the created category" do
        post :create, {:category =>  attributes_for(:category)}, valid_session
        response.should redirect_to(Category.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  :name => ""}}, valid_session
        assigns(:category).to be _a_new(Category)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  :name => ""}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      it "assigns the requested category as @category" do
        category = create :category
        put :update, {:id => category.to_param, :category =>  attributes_for(:category)}, valid_session
        assigns(:category).to eq(category)
      end

      it "redirects to the category" do
        category = create :category
        put :update, {:id => category.to_param, :category =>  attributes_for(:category)}, valid_session
        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = create :category
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { :name => "" }}, valid_session
        assigns(:category).to eq(category)
      end

      it "re-renders the 'edit' template" do
        category = create :category
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => { :name => ""}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = create :category
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = create :category
      delete :destroy, {:id => category.to_param}, valid_session
      response.should redirect_to(categories_url)
    end
  end

end
