require 'spec_helper'

describe "GET /products" do
  before :each do
    sign_in
   end
   it "lists no products" do
     visit_path products_path
     expect(product_count).to be 0
   end
   it "lists correct number of unfiltered products" do
     create_ab :price => [8 ,12,14,16]
     expect(product_count).to be 4
   end
  it "filters by price" do
    create_ab :price => [8 ,12]
    fill_in "q[price_lteq]", :with => '10'
    click_button(:filter)
    expect(product_count).to be 1
  end
  it "filters by online" do
    create_ab :online => [true, false]
    choose("q[online_eq]")
    click_button( :filter)
    expect(product_count).to be 1
  end
  it "filters by empty summary" do
    create_ab :summary =>[ "i have a summary", ""]
    choose("q[summary_blank]")
    click_button(:filter)
    expect(product_count).to be 1
  end
end
