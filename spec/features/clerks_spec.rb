require 'spec_helper'

describe Clerk  do
  it "lists product groups" do
    visit clerks_path
    should_translate page
  end
  it "creates a new group" do
    visit new_clerk_path
    should_translate page
  end
  it "edit" do
    @clerk = create(:clerk)
    visit edit_clerk_path(@clerk)
    should_translate page
  end
  it "shows" do
    @clerk = create(:clerk)
    visit clerk_path(@clerk)
    should_translate page
  end
end
