

describe Clerk do

  it "should return last order address with empty for no order" do
    clerk = create(:clerk)
    expect(clerk.last_address).to be {}
  end

  it "should return last order address with last order address" do
    order = create :order
    order.name = "clerk name"
    order.city = "my city"
    order.save!
    clerk = create(:clerk , :email => order.email)
    expect(clerk.last_address).to eq order.address
  end

end