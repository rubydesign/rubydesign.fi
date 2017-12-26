describe Category  do
  before(:each) do
    sign_in
  end
  it "creates a new group" do
    visit_path new_category_path
  end
  context "existing" do
    before :each do
      @category = create(:category)
    end
    it "lists product groups" do
      visit_path categories_path
    end
    it :edit do
      visit_path edit_category_path(@category)
    end
    it "shows" do
      visit_path category_path(@category)
    end
    it "has delete link" do
      visit_path category_path(@category)
      expect(page).to have_link(I18n.t(:delete))
    end
    it "deletes" do
      visit_path category_path(@category)
      click_link(I18n.t(:delete))
      expect(current_path).to eq categories_path
    end
  end
end
