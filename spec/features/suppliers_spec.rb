

describe "Suppliers" do
  before(:each) do
    sign_in
    @supplier = create(:supplier)
  end
  it "lists suppliers" do
    create(:supplier)
    visit_path suppliers_path
  end
  it "shows" do
    visit_path supplier_path(@supplier)
  end
  it "edits" do
    visit_path edit_supplier_path(@supplier)
  end
  it "has delete link" do
    visit_path supplier_path(@supplier)
    expect(page).to have_link(I18n.t(:delete))
  end
  it "deletes" do
    visit_path supplier_path(@supplier)
    click_link(I18n.t(:delete))
    expect(current_path).to eq suppliers_path
  end
end
