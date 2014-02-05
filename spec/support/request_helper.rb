module PageHelper
  def should_translate page
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end

  def ensure_admin
    email = "admin@important.me"
    admin = Clerk.where( :email => email).first
    admin.should_not be nil
    admin
  end
  
  def sign_in
    admin = ensure_admin
    visit sign_in_path
    fill_in "email" , :with => "torsten@villataika.fi" #admin.email
    fill_in "password" , :with => "rakkaus"
    click_button I18n.t(:sign_in)
    expect(page).to have_content I18n.t(:baskets)
  end
end
