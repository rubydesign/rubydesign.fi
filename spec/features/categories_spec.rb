require 'spec_helper'

describe Category  do
  before(:each) do
    sign_in
  end
  it "lists product groups" do
    visit_path categories_path
  end
  it "creates a new group" do
    visit_path new_category_path
  end
  it "edit" do
    @category = create(:category)
    visit_path edit_category_path(@category)
  end
  it "shows" do
    @category = create(:category)
    visit_path category_path(@category)
  end
end
