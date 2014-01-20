require 'spec_helper'

describe "new product" do
  before :each do
    visit new_product_path
    fill_in "product_name", :with => 'product 12'
    fill_in "product_price", :with => '12'
  end
  it "renders" do
    status_code.should be 200
    translates page
  end
  it "submits ok" do
    click_button( 'Create Product')
    status_code.should be 200
    expect(page).to have_content I18n.t(:create_success)
  end
  it "redirects ok" do
    fill_in "product_price", :with => ''
    click_button( 'Create Product')
    status_code.should be 200
    expect(page).to have_content "not a number"
  end
end
