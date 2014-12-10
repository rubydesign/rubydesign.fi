require "spec_helper"

RSpec.describe OrderMailer, :type => :mailer do
  describe 'confirm' do
    let(:order) { create :order }
    let(:mail) { OrderMailer.confirm(order) }
 
    it 'renders the subject' do
      expect(mail.subject.to_s).to include( I18n.t(:order))
      expect(mail.subject.to_s).to include( order.number)
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eql([order.email])
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eql(["me@here.now"]) #configured in config.yml
    end
    
    it "includes the total price" do
      expect(mail.body).to include(order.total_price.to_s)
    end

    it "includes the product name" do
      expect(mail.body).to include(order.basket.items.first.product.name)
    end
    
  end
end
