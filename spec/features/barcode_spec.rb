require 'spec_helper'

describe "barcode" , :js => true  do
  before :each do
    sign_in
  end
  it "shows product" do
    product = create :product
    visit_path product_path product
    expect(page).to have_content I18n.t(:barcode)
  end
end
