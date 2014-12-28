require "spec_helper"

RSpec.describe OrderMailer, :type => :mailer do
  let(:order) { create :order }

  shared_examples_for "an order mail" do
    describe "mail basics" do
      it 'renders the subject' do
        expect(mail.subject.to_s).to include( I18n.t(:order))
        expect(mail.subject.to_s).to include( order.number)
        expect(mail.subject.to_s).not_to include( "missing")
      end
      it 'renders the receiver email' do
        expect(mail.to).to eq([order.email])
      end
    end
    describe "order details" do
      it "includes the total price" do
        expect(mail.body).to include(order.total_price.to_s)
      end
      it "includes the product name" do
        expect(mail.body).to include(order.basket.items.first.product.name)
        expect(mail.body).not_to include( "missing")
      end
    end
  end

  describe 'confirm mail' do
    let(:mail) { OrderMailer.confirm(order) }
    it_should_behave_like "an order mail" do
    end
    it "should include ordered" do
      expect(mail.body).to include("vastaanotettu")
    end
  end

  describe 'cancel mail' do
    let(:mail) { OrderMailer.cancel(order) }
    it_should_behave_like "an order mail" do
    end
    it "should include cancled" do
      expect(mail.body).to include("peruttu")
    end
  end

  describe 'paid mail' do
    let(:mail) { OrderMailer.paid(order) }
    it_should_behave_like "an order mail" do
    end
    it "should include paid" do
      expect(mail.body).to include("kirjattu maksetuksi")
    end
  end

  describe 'shipped mail' do
    let(:mail) do
      order.pay_now
      order.save
      OrderMailer.shipped(order)
    end
    it_should_behave_like "an order mail" do
    end
    it "should include paid" do
      expect(mail.body).to include("postitettu")
    end
  end

end
