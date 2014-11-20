require 'spec_helper'

feature "new product" do
  before :each do
    sign_in
  end
  it "renders new and fails without data" do
    visit_path new_product_path
    click_button( I18n.t(:create))
    expect(page.current_path).to eq products_path
    expect(page).to have_content I18n.t("errors.messages.not_a_number")
    expect(Product.count).to eq 0
  end
  it "submits ok with correct data" do
    visit_path new_product_path
    fill_in "product_name", :with => 'product 12'
    fill_in "product_price", :with => '12'
    click_button( I18n.t(:create))
    expect(page).to have_content I18n.t(:create_success)
    expect(Product.count).to eq 1
  end
  it "renders product edit" do
    product = create :product
    visit_path edit_product_path(product) 
    click_button( I18n.t(:product))
    ensure_path product_path(product)
  end
end
