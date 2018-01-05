

describe "Basket index/search page" do
  before(:each) do
    sign_in
  end
  it "empty page works" do
    visit_path baskets_path
  end
  it "lists baskets" do
    create :basket
    create :basket_with_item
    create :purchase_received
    create :order_ordered
    create :order_paid
    create :order_shipped
    visit_path baskets_path
  end
end
