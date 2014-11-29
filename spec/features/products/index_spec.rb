require 'spec_helper'

describe "GET /products" do
  before :each do
    sign_in
   end
  it "lists no products" do
    visit_path products_path
    expect(all(".image").count).to be 0
  end
  it "filters by price" do
    create :product , :price => 8
    create :product , :price => 12
    visit products_path
    fill_in "q[price_lteq]", :with => '10'
    expect(all(".image").count).to be 2
    click_button( :filter)
    expect(all(".image").count).to be 1
  end
  it "filters by online" do
    create :product , :online => true
    create :product , :online => false
    visit products_path
    expect(all(".image").count).to be 2
    choose("q[online_eq]")
    click_button( :filter)
    expect(all(".image").count).to be 1
  end
  it "filters by empty summary" do
    create :product , :summary => "i have a summary"
    create :product , :summary => ""
    visit products_path
    expect(all(".image").count).to be 2
    choose("q[summary_blank]")
    click_button( :filter)
    expect(all(".image").count).to be 1
  end
end
