require "spec_helper"

RSpec.describe OrderMailer, :type => :mailer do
  describe 'confirm' do
    let(:order) { create :order }
    let(:mail) { OrderMailer.confirm(order) }
 
    it 'renders the subject' do
      expect(mail.subject.to_s).to include('Order')
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eql([order.email])
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eql(["me@here.now"])
    end
    
    it "includes the total price" do
      expect(mail.body).to include(order.total_price.to_s)
    end
  end
end
