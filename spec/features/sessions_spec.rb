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
    ensure_path Rails.application.routes.url_helpers.root_path
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
  it "signs out" do
    sign_in
    visit sign_out_path
    ensure_path Rails.application.routes.url_helpers.root_path
  end
  it "signs up needs confirmation" do
    visit_path sign_up_path
    fill_in(:clerk_email , :with => "some@mail.me")
    fill_in(:clerk_password , :with => "password")
    find(".submit").click
    ensure_path sign_up_path
  end
  it "signs up" do
    visit_path sign_up_path
    fill_in(:clerk_email , :with => "some@mail.me")
    fill_in(:clerk_password , :with => "password")
    fill_in(:clerk_password_confirmation , :with => "password")
    find(".submit").click
    ensure_path main_app.root_path
  end
end
