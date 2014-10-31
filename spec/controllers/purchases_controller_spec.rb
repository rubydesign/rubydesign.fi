require 'spec_helper'

describe PurchasesController do

  # This should return the minimal set of attributes required to create a valid
  # Purchase. As you add validations to Purchase, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :purchase }

  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all purchases as @purchases" do
      count_before = Purchase.count
      purchase = create :purchase
      get :index, {}, valid_session
      assigns(:purchases).count.to be  count_before + 1
    end
  end

  describe "GET show" do
    it "assigns the requested purchase as @purchase" do
      purchase = Purchase.create! valid_attributes
      get :show, {:id => purchase.to_param}, valid_session
      assigns(:purchase).to eq(purchase)
    end
  end

  describe "GET new" do
    it "assigns a new purchase as @purchase" do
      get :new, {}, valid_session
      assigns(:purchase).to be _a_new(Purchase)
    end
  end

  describe "GET edit" do
    it "assigns the requested purchase as @purchase" do
      purchase = Purchase.create! valid_attributes
      get :edit, {:id => purchase.to_param}, valid_session
      assigns(:purchase).to eq(purchase)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Purchase" do
        expect {
          post :create, {:purchase => valid_attributes}, valid_session
        }.to change(Purchase, :count).by(1)
      end

      it "assigns a newly created purchase as @purchase" do
        post :create, {:purchase => valid_attributes}, valid_session
        assigns(:purchase).to be _a(Purchase)
        assigns(:purchase).to be _persisted
      end

      it "redirects to the created purchase" do
        post :create, {:purchase => valid_attributes}, valid_session
        response.should redirect_to(Purchase.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved purchase as @purchase" do
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        post :create, {:purchase => {  :supplier_id => nil }}, valid_session
        assigns(:purchase).to be _a_new(Purchase)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        post :create, {:purchase => {  :supplier_id => nil }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested purchase as @purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, {:id => purchase.to_param, :purchase => valid_attributes}, valid_session
        assigns(:purchase).to eq(purchase)
      end

      it "redirects to the purchase" do
        purchase = Purchase.create! valid_attributes
        put :update, {:id => purchase.to_param, :purchase => valid_attributes}, valid_session
        response.should redirect_to(purchase)
      end
    end

    describe "with invalid params" do
      it "assigns the purchase as @purchase" do
        purchase = Purchase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        put :update, {:id => purchase.to_param, :purchase => {  :supplier_id => nil }}, valid_session
        assigns(:purchase).to eq(purchase)
      end

      it "re-renders the 'edit' template" do
        purchase = Purchase.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Purchase.any_instance.stub(:save).and_return(false)
        put :update, {:id => purchase.to_param, :purchase => {  :supplier_id => nil }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested purchase" do
      purchase = Purchase.create! valid_attributes
      expect {
        delete :destroy, {:id => purchase.to_param}, valid_session
      }.to change(Purchase, :count).by(-1)
    end

    it "redirects to the purchases list" do
      purchase = Purchase.create! valid_attributes
      delete :destroy, {:id => purchase.to_param}, valid_session
      response.should redirect_to(purchases_url)
    end
  end

end
