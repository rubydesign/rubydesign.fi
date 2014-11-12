require 'spec_helper'

#Note of incompleteness:
# this is close to the original generated code and tests more crud than the actual basket functionality
# things are better in the features test (where adding item and the like is actually tested)

describe BasketsController do
  routes { OfficeClerk::Engine.routes }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BasketsController. Be sure to keep this updated.
  before :all do
    create :admin  unless Clerk.where(:admin => true).first
  end  
  let(:valid_session) { { :clerk_email => Clerk.where(:admin => true).first.email } }

  describe "GET index" do
    it "assigns all baskets as @baskets" do
      count_before = Basket.count
      basket = create :basket
      get :index, {}, valid_session
      expect(assigns(:basket_scope).count).to be  count_before + 1
    end
  end

  describe "GET show" do
    it "assigns the requested basket as @basket" do
      basket = create :basket
      get :show, {:id => basket.to_param}, valid_session
      expect(assigns(:basket)).to eq(basket)
    end
  end

  describe "GET new" do
    it "assigns a new basket as @basket" do
      get :new, {}, valid_session
      expect(assigns(:basket)).to be_kind_of(Basket)
    end
  end

  describe "GET edit" do
    it "assigns the requested basket as @basket" do
      basket = create :basket
      get :edit, {:id => basket.to_param}, valid_session
      expect(assigns(:basket)).to eq(basket)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Basket" do
        expect {
          post :create, {:basket => attributes_for(:basket)}, valid_session
        }.to change(Basket, :count).by(1)
      end

      it "assigns a newly created basket as @basket" do
        post :create, {:basket => attributes_for(:basket)}, valid_session
        expect(assigns(:basket)).to be_kind_of(Basket)
        expect(assigns(:basket)).to be_persisted
      end

      it "redirects to the created basket" do
        post :create, {:basket => attributes_for(:basket)}, valid_session
        expect(response).to redirect_to(Basket.first)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested basket as @basket" do
        basket = create :basket
        put :update, {:id => basket.to_param, :basket => attributes_for(:basket)}, valid_session
        expect(assigns(:basket)).to eq(basket)
      end

      it "redirects to the basket" do
        basket = create :basket
        put :update, {:id => basket.to_param, :basket => attributes_for(:basket)}, valid_session
        expect(response).to redirect_to( :action => :edit , :id => basket.id)
      end
    end

    describe "with invalid params" do
      it "assigns the basket as @basket" do
        basket = create :basket
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Basket).to receive(:save).and_return(false)
        put :update, {:id => basket.to_param, :basket => { :some => :thing_to_stop_erros  }}, valid_session
        expect(assigns(:basket)).to eq(basket)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested basket" do
      basket = create :basket
      expect {
        delete :destroy, {:id => basket.to_param}, valid_session
      }.to change(Basket, :count).by(-1)
    end

    it "redirects to the baskets list" do
      basket = create :basket
      delete :destroy, {:id => basket.to_param}, valid_session
      expect(response).to redirect_to(baskets_path)
    end
  end

end
