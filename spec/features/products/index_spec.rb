require 'spec_helper'

describe "GET /products" do
  before :each do
     visit products_path
   end
  it "lists products" do
    should_translate page
  end
end
describe "product filtering" do
  before :each do
    20.times { create :product }
    visit products_path
   end
  it "filters by price" do
    fill_in "q_price_gteq", :with => '10'
    click_button( 'Filter')
  end
end
describe "edit product" do
  it "renders" do
    product = create :product
    visit edit_product_path product
    should_translate page
  end
end
