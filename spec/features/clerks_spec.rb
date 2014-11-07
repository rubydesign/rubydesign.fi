require 'spec_helper'

describe Clerk  do
  before(:each) do
    sign_in
  end
  it "lists clerks" do
    visit_path clerks_path
  end
  it "shows" do
    clerk = create(:clerk)
    visit_path clerk_path(clerk)
  end
  it "creates a new clerk ok" do
    visit_path new_clerk_path
    fill_in :clerk_email , :with => "some@valid.it"
    fill_in :clerk_password , :with => "my_password"
    fill_in :clerk_password_confirmation , :with => "my_password"
    click_button :submit
    expect(page.current_url).to include("/clerks/")
  end
  it "edits a clerk" do
    clerk = create(:clerk)
    visit_path edit_clerk_path(clerk)
    fill_in :clerk_name , :with => "my name"
    click_button :submit
    ensure_path clerk_path(clerk)    
  end
  it "does not creates a new clerk if passwords mismatch" do
    visit_path new_clerk_path
    fill_in :clerk_email , :with => "some@valid.it"
    fill_in :clerk_password , :with => "my_password"
    fill_in :clerk_password_confirmation , :with => "my_other_password"
    click_button :submit
    ensure_path clerks_path
  end
end
