

describe "header texts" do
  before :each do
    sign_in
  end
  it "product new" do
    visit_path new_product_path
    expect(page).to have_content I18n.t(:product)
    expect(page).to have_content I18n.t(:new)
  end
  it "edits product" do
    product = create :product
    visit_path edit_product_path product
    expect(page).to have_content I18n.t(:product)
    expect(page).to have_content I18n.t(:edit)
  end
  it "edits product line" do
    product = create :product_line
    visit_path edit_product_path product
    expect(page).to have_content I18n.t(:product_line)
    expect(page).to have_content I18n.t(:edit)
  end
  it "edits product item" do
    product = create :product_line
    visit_path edit_product_path product.products.first
    expect(page).to have_content I18n.t(:product_item)
    expect(page).to have_content I18n.t(:edit)
  end
  it "shows product" do
    product = create :product
    visit_path product_path product
    expect(page).to have_content I18n.t(:product)
    expect(page).to have_content I18n.t(:show)
  end
  it "shows product line" do
    product = create :product_line
    visit_path product_path product
    expect(page).to have_content I18n.t(:product_line)
    expect(page).to have_content I18n.t(:show)
  end
  it "shows product item" do
    product = create :product_line
    visit_path product_path product.products.first
    expect(page).to have_content I18n.t(:product_item)
    expect(page).to have_content I18n.t(:show)
  end
end
