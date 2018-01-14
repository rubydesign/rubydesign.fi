

describe "header texts" do
  before :each do
    sign_in
  end
  it "edits product" do
    product = create :product
    visit_path edit_product_path product
    expect(page).to have_content I18n.t(:product)
  end
  it "edits product line" do
    product = create :product_line
    visit_path edit_product_path product
    expect(page).to have_content I18n.t(:product_line)
  end
  it "edits product item" do
    product = create :product_line
    visit_path edit_product_path product.products.first
    expect(page).to have_content I18n.t(:product_item)
  end
  it "shows product" do
    product = create :product
    visit_path product_path product
    expect(page).to have_content I18n.t(:product)
  end
  it "shows product line" do
    product = create :product_line
    visit_path product_path product
    expect(page).to have_content I18n.t(:product_line)
  end
  it "shows product item" do
    product = create :product_line
    visit_path product_path product.products.first
    expect(page).to have_content I18n.t(:product_item)
  end
end
