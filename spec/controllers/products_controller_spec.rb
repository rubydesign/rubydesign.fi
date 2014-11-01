require 'spec_helper'

describe ProductsController do

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :product }

  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all products as @products" do
      product = Product.create! valid_attributes
      get :index, {}, valid_session
#      assigns(:products).to eq([product])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      expect(assigns(:product)).to be_kind_of(Product)
      expect(assigns(:product)).to be_new_record
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(assigns(:product)).to be_kind_of(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(response).to redirect_to(Product.first)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Product).to receive(:save).and_return(false)
        post :create, {:product => {  :name => "" }}, valid_session
        expect(assigns(:product)).to be_kind_of(Product)
        expect(assigns(:product)).to be_new_record
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Product).to receive(:save).and_return(false)
        post :create, {:product => {  :name => "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(response).to redirect_to(product)
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Product).to receive(:save).and_return(false)
        put :update, {:id => product.to_param, :product => {  :name => "" }}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Product).to receive(:save).and_return(false)
        put :update, {:id => product.to_param, :product => {  :name => "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "deletes the requested product" do
      product = Product.create! valid_attributes
      before = Product.count
      delete :delete, {:id => product.to_param}, valid_session
      expect(Product.count).to be  before - 1
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :delete, {:id => product.to_param}, valid_session
      expect(response).to redirect_to(products_path)
    end
  end

end
