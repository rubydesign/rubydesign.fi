module PageHelper
  def ensure_path path
    page.current_path.should == path
  end
  def visit_path path
    visit path
    status_code.should be 200
    page.should_not have_css(".translation_missing")
    ensure_path path
  end

  def ensure_admin
    admin = create :admin
    admin.should_not be nil
    admin
  end
  
  def sign_in
    admin = ensure_admin
    visit sign_in_path
    fill_in "email" , :with => admin.email
    fill_in "password" , :with => "password"
    click_button I18n.t(:sign_in)
    expect(page).to have_content I18n.t(:baskets)
  end
end
