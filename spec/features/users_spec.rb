require 'spec_helper'

describe User  do
  it "lists product groups" do
    visit users_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "creates a new group" do
    visit new_user_path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "edit" do
    @user = create(:user)
    visit edit_user_path(@user)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
  it "shows" do
    @user = create(:user)
    visit user_path(@user)
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
end
