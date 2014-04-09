require 'spec_helper'

describe OrdersController do

  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all orders as @orders" do
      count_before = Order.count
      basket = create :order
      get :index, {}, valid_session
      assigns(:order_scope).count.should be count_before + 1
    end
  end

  describe "GET show" do
    it "assigns the requested order as @order" do
      order = create :order
      get :show, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end

  describe "GET new" do
    it "assigns a new order as @order" do
      get :new, {}, valid_session
      assigns(:order).should be_a_new(Order)
    end
  end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      order = create :order
      get :edit, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, {:order => attributes_for(:order)}, valid_session
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created order as @order" do
        post :create, {:order => attributes_for(:order)}, valid_session
        assigns(:order).should be_a(Order)
        assigns(:order).should be_persisted
      end

      it "redirects to the created order" do
        post :create, {:order => attributes_for(:order)}, valid_session
        response.should redirect_to(Order.first)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        post :create, {:order => {  :paid_on => ""}}, valid_session
        assigns(:order).should be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        post :create, {:order => {  :paid_on => ""}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested order as @order" do
        order = create :order
        put :update, {:id => order.to_param, :order => attributes_for(:order)}, valid_session
        assigns(:order).should eq(order)
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        order = create :order
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {  :paid_on => ""}}, valid_session
        assigns(:order).should eq(order)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested order" do
      order = create :order
      expect {
        delete :destroy, {:id => order.to_param}, valid_session
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order = create :order
      delete :destroy, {:id => order.to_param}, valid_session
      response.should redirect_to(orders_url)
    end
  end

end
