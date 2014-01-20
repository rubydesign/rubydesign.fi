require 'spec_helper'

describe Category  do
  it "lists product groups" do
    visit categories_path
    status_code.should be 200
    translates page
  end
  it "creates a new group" do
    visit new_category_path
    status_code.should be 200
    translates page
  end
  it "edit" do
    @category = create(:category)
    visit edit_category_path(@category)
    status_code.should be 200
    translates page
  end
  it "shows" do
    @category = create(:category)
    visit category_path(@category)
    status_code.should be 200
    translates page
  end
end
