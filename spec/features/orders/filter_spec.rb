

describe "Order index" do
  before(:each) do
    sign_in
  end
  it "lists orders" do
    visit_path orders_path
  end
  it "creates new order" do
    visit_path orders_path
    find(".new_order").click
  end
  it "filters by email" do
    order_ab :email =>[ "torsten@villataika.fi", "raisa@villataika.fi"]
    fill_in("q[email_cont]" , :with => "torsten")
    expect(order_count).to eq 1
  end
  it "filters by R num" do
    order_ab :order_number =>[ 202034847, 202034848]
    fill_in("q[order_number_eq]" , :with => "R202034847")
    expect(order_count).to eq 1
  end
  it "filters by viite num" do
    order_ab :order_number =>[ 202034847, 202034848]
    fill_in("q[order_number_eq]" , :with => "2020348479")
    expect(order_count).to eq 1
  end
end
