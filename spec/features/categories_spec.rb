require 'spec_helper'

describe Category  do
  it "lists product groups" do
    visit categories_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "creates a new group" do
    visit new_category_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "edit" do
    @category = create(:category)
    visit edit_category_path(@category)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "shows" do
    @category = create(:category)
    visit category_path(@category)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
end
