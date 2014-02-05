require 'spec_helper'

feature "new product" do
  before :each do
    sign_in
    visit_path new_product_path
    expect(page).to have_content I18n.t(:product)
    fill_in "product[name]", :with => 'product 12'
    fill_in "product[price]", :with => '12'
  end
  it "submits ok" do
    click_button( I18n.t(:create))
    expect(page).to have_content I18n.t(:create_success)
  end
  scenario "redirects ok" do
    fill_in "product_price", :with => ''
    click_button( I18n.t(:create))
    expect(page).to have_content I18n.t("errors.messages.not_a_number")
  end
end
