

describe "header texts" do
  before :each do
    sign_in
  end
  it "edits product" do
    product = create :product
    visit_path edit_product_path product
    expect(page).to have_content I18n.t(:product)
  end
  it "shows product" do
    product = create :product
    visit_path product_path product
    expect(page).to have_content I18n.t(:product)
  end
end
