require 'spec_helper'

describe User  do
  it "lists product groups" do
    visit users_path
    should_translate page
  end
  it "creates a new group" do
    visit new_user_path
    should_translate page
  end
  it "edit" do
    @user = create(:user)
    visit edit_user_path(@user)
    should_translate page
  end
  it "shows" do
    @user = create(:user)
    visit user_path(@user)
    should_translate page
  end
end
