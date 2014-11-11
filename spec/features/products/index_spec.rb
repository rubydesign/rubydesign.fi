require 'spec_helper'

describe "GET /products" do
  before :each do
    sign_in
   end
  it "lists no products" do
    visit_path products_path
  end
  it "filters by price" do
    10.times { create :product }
    visit products_path
    fill_in "q[price_lteq]", :with => '10'
    click_button( I18n.t(:filter))
  end
end
