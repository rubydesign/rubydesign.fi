require 'spec_helper'

describe "GET /products" do
  before :each do
    sign_in
    visit_path products_path
   end
  it "lists products" do
  end
end
describe "product filtering" do
  before :each do
    20.times { create :product }
    sign_in
    visit products_path
   end
  it "filters by price" do
    fill_in "q[price_lteq]", :with => '10'
    click_button( I18n.t(:filter))
  end
end
describe "edit product" do
  before :each do
    sign_in
  end
  it "renders" do
    product = create :product
    visit_path edit_product_path(product) 
  end
end
