module PageHelper
  def ensure_path path
    expect(page.current_path).to eq path
  end
  def visit_path path
    visit path
    expect(status_code).to be 200
    expect(page).not_to have_css(".translation_missing")
    ensure_path path
  end

  def ensure_admin
    admin = Clerk.where(:admin => true).first
    admin = create :admin unless admin
    expect(admin).not_to be nil
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

  def expect_basket_total price
    expect(find(".total").text).to include( price.round(2).to_s.sub(".",",")) # TODO remove the format hack 
  end
end
