require 'spec_helper'

describe "Sessions" do
  it "redirect to sign in when accessing admin" do
    visit suppliers_path
    ensure_path sign_in_path
  end
  it "signs in with account" do
    user = create :clerk 
    visit_path sign_in_path
    fill_in(:email , :with => user.email)
    fill_in(:password , :with => "password")
    click_button( I18n.t(:sign_in))
    ensure_path root_path
  end
  it "goes to baskets for admins" do
    user = create :admin
    visit_path sign_in_path
    fill_in(:email , :with => user.email)
    fill_in(:password , :with => "password")
    click_button( I18n.t(:sign_in))
    ensure_path baskets_path
  end
  it "doesnt sign in without password" do
    user = create :clerk
    visit_path sign_in_path
    fill_in(:email , :with => user.email)
    click_button( I18n.t(:sign_in))
    ensure_path sign_in_path
  end
  it "does not sign in without account" do
    visit_path sign_in_path
    fill_in(:email , :with => "random@email")
    click_button( I18n.t(:sign_in))
    ensure_path sign_in_path
  end

end
