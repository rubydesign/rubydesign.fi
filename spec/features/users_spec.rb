require 'spec_helper'

describe User  do
  it "lists product groups" do
    visit users_path
    status_code.should be 200
    translates page
  end
  it "creates a new group" do
    visit new_user_path
    status_code.should be 200
    translates page
  end
  it "edit" do
    @user = create(:user)
    visit edit_user_path(@user)
    status_code.should be 200
    translates page
  end
  it "shows" do
    @user = create(:user)
    visit user_path(@user)
    status_code.should be 200
    translates page
  end
end
