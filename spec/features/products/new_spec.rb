require 'spec_helper'

feature "new product" do
  before :each do
    sign_in
    visit new_product_path
    expect(page).to have_content I18n.t(:product)
    fill_in "product[name]", :with => 'product 12'
    fill_in "product[price]", :with => '12'
  end
  it "renders" do
    should_translate page
  end
#  it "submits ok" do
 #   click_button( 'Create Product')
  #  expect(page).to have_content I18n.t(:create_success)
  #end
#  scenario "redirects ok" do
#    fill_in "product_price", :with => ''
#    click_button( 'Create Product')
#    expect(page).to have_content "not a number"
#  end
end
