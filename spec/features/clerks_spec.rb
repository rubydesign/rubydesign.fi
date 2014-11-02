require 'spec_helper'

describe Clerk  do
  before(:each) do
    sign_in
  end
  it "lists product groups" do
    visit_path clerks_path
  end
  it "creates a new group" do
    visit_path new_clerk_path
  end
  it "edit" do
    clerk = create(:clerk)
    visit_path edit_clerk_path(clerk)
  end
  it "shows" do
    clerk = create(:clerk)
    visit_path clerk_path(clerk)
  end
end
