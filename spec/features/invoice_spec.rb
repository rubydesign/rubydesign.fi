require 'spec_helper'

describe "Orders" do
  before(:each) do
    sign_in
  end
  it "should render print buttons" , :js => true do
    order = create :order
    visit_path order_path order
    RubyClerks.config(:print_styles).split.each do |style|
      expect(page).to have_link("" , href: "/orders/#{order.id}/#{style}")
    end
  end
  describe "invoice" do
    it "shows total" do
      order = create :order_ordered
      visit_path "#{order_path(order)}/invoice"
      expect(page).to have_content I18n.t(:order_total)
    end
    it "uses best_euros to render price" do
      order = create :order_ordered
      #TODO expect(???).to receive(:best_euros)
      visit_path "#{order_path(order)}/invoice"
    end
  end

  it "should render print button", js: true do
    purchase = create :purchase
    visit_path purchase_path(purchase)
    expect(page).to have_link("Print Invoice" , href: "/purchases/#{purchase.id}/invoice")
  end
  describe "purchase invoice" do
    it "shows total" do
      purchase = create :purchase
      visit_path "#{purchase_path(purchase)}/invoice"
      expect(page).to have_content I18n.t(:purchase_total)
    end
  end
end
