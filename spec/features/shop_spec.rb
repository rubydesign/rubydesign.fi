require 'spec_helper'

describe ShopController  do
  it "lists shows root" do
    prod = create :shop_product
    visit_path root_path
  end
  it "shows a product" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
  end
  it "redirects for non product" do
    prod = create :shop_product
    visit shop_product_path("no_such_thing")
    ensure_path shop_group_path("no_such_thing")
  end
  it "shows a group" do
    prod = create :shop_product
    visit_path shop_group_path(prod.category.link)
  end
  it "adds a product" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    ensure_path shop_group_path(prod.category.link)
  end
  it "adds a product" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    ensure_path shop_group_path(prod.category.link)
  end
  it "adds a product to checkout" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    visit_path shop_checkout_path
  end
  it "fails checkout without email" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    visit_path shop_checkout_path
    click_button "make_order"
    expect(page).to have_content("Error")
    ensure_path shop_checkout_path
  end
  it "checks out with email" do
    prod = create :shop_product
    visit_path shop_product_path(prod.link)
    click_button "add-to-cart-button"
    visit_path shop_checkout_path
    fill_in :order_email , :with => "some@valid.it"
    click_button "make_order"
    ensure_path shop_order_path(Order.last.id)
  end
  it "shows a page" do
    visit_path shop_page_path :tuotteista
  end
  it "renders welcome page" do
    visit_path shop_welcome_path
  end
end
