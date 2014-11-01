require 'spec_helper'

describe SuppliersController do

  # This should return the minimal set of attributes required to create a valid
  # Supplier. As you add validations to Supplier, be sure to
  # adjust the attributes here as well.
  let(:supplier_attributes) do
     {:supplier => attributes_for(:supplier)}
   end
   before :all do
     create :admin  unless Clerk.where(:admin => true).first
   end  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuppliersController. Be sure to keep this updated too.
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all suppliers as @suppliers" do
      before = Supplier.count
      create :supplier
      get :index, {}, valid_session
      expect(Supplier.count).to be  before + 1
    end
  end

  describe "GET show" do
    it "assigns the requested supplier as @supplier" do
      supplier = create :supplier
      get :show, {:id => supplier.to_param}, valid_session
      expect(assigns(:supplier)).to eq(supplier)
    end
  end

  describe "GET new" do
    it "assigns a new supplier as @supplier" do
      get :new, {}, valid_session
      expect(assigns(:supplier)).to be_kind_of(Supplier)
      expect(assigns(:supplier)).to be_new_record
    end
  end

  describe "GET edit" do
    it "assigns the requested supplier as @supplier" do
      supplier = create :supplier
      get :edit, {:id => supplier.to_param}, valid_session
      expect(assigns(:supplier)).to eq(supplier)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Supplier" do
        expect {
          post :create, supplier_attributes, valid_session
        }.to change(Supplier, :count).by(1)
      end

      it "assigns a newly created supplier as @supplier" do
        post :create, supplier_attributes, valid_session
        expect(assigns(:supplier)).to be_kind_of(Supplier)
        expect(assigns(:supplier)).to be_persisted
      end

      it "redirects to the created supplier" do
        post :create, supplier_attributes , valid_session
        expect(response).to redirect_to(Supplier.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved supplier as @supplier" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Supplier).to receive(:save).and_return(false)
        post :create, {:supplier => {  :name  => "" }}, valid_session
        expect(assigns(:supplier)).to be_kind_of(Supplier)
        expect(assigns(:supplier)).to be_new_record
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Supplier).to receive(:save).and_return(false)
        post :create, {:supplier => {  :name  => "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested supplier as @supplier" do
        supplier = create :supplier
        attributes = supplier_attributes
        attributes[:id] = supplier.id
        put :update, attributes , valid_session
        expect(response).to redirect_to(supplier)
        expect(assigns(:supplier)).to eq(supplier)
      end
    end

    describe "with invalid params" do
      it "assigns the supplier as @supplier" do
        supplier = create :supplier
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Supplier).to receive(:save).and_return(false)
        put :update, {:id => supplier.to_param, :supplier => {  :name  => "" }}, valid_session
        expect(assigns(:supplier)).to eq(supplier)
      end

      it "re-renders the 'edit' template" do
        supplier = create :supplier
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Supplier).to receive(:save).and_return(false)
        put :update, {:id => supplier.to_param, :supplier => {  :name  => "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested supplier" do
      supplier = create :supplier
      expect {
        delete :destroy, {:id => supplier.to_param}, valid_session
      }.to change(Supplier, :count).by(0)
    end

    it "redirects to the suppliers list" do
      supplier = create :supplier
      delete :destroy, {:id => supplier.to_param}, valid_session
      expect(response).to redirect_to(suppliers_path)
    end
  end

end
