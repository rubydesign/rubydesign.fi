require 'spec_helper'

describe ProductGroup  do
  it "lists product groups" do
    visit product_groups_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "creates a new group" do
    visit new_product_group_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "edit" do
    @product_group = create(:product_group)
    visit edit_product_group_path(@product_group)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "shows" do
    @product_group = create(:product_group)
    visit product_group_path(@product_group)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
end
