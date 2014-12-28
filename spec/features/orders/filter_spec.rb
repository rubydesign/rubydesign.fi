require 'spec_helper'

describe "Order index" do
  before(:each) do
    sign_in
  end
  it "lists orders" do
    visit_path orders_path
  end
  it "filters by email" do
    order_ab :email =>[ "torsten@villataika.fi", "raisa@villataika.fi"]
    fill_in("q[email_cont]" , :with => "torsten")
    expect(order_count).to eq 1
  end
end
