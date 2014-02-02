module PageHelper
  def should_translate page
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end

  def ensure_admin
    email = "admin35@admin.com"
    admin = Clerk.where( :email => email).first
    admin = create(:clerk , :email => email , :admin => true )  unless admin
    admin.stub(:password).and_return("password")
    admin
  end
  
  def sign_in
    admin = ensure_admin
    visit sign_in_path
    fill_in "email" , :with => "torsten@villataika.fi" #admin.email
    fill_in "password" , :with => "rakkaus" #admin.password
    click_link I18n.t(:sign_in)
    #puts "Locale #{I18n.default_locale}"
    expect(page).to have_content I18n.t(:baskets)
  end
end
