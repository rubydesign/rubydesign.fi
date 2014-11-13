require "spec_helper"

describe BasketsController do
 routes { OfficeClerk::Engine.routes }
  
  describe "routing" do

    it "routes to #index" do
      expect(get("/baskets")).to route_to("baskets#index")
    end

    it "routes to #new" do
      expect(get("/baskets/new")).to route_to("baskets#new")
    end

    it "routes to #show" do
      expect(get("/baskets/1")).to route_to("baskets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/baskets/1/edit")).to route_to("baskets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/baskets")).to route_to("baskets#create")
    end

    it "routes to #update" do
      expect(put("/baskets/1")).to route_to("baskets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/baskets/1")).to route_to("baskets#destroy", :id => "1")
    end

  end
end
