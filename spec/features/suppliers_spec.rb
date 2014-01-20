require 'spec_helper'

describe "Suppliers" do
  describe "GET /suppliers" do
    it "lists suppliers" do
      visit suppliers_path
      should_translate page
    end
  end
end
