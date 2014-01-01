# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    ordered_on "2013-12-26"
    total_price 1.5
    total_tax 1.5
    shipping_price 1.5
    shipping_tax 1.5
    email "MyString"
    paid_on "2013-12-26"
    shipped_on "2013-12-26"
    canceled_on "2013-12-26"
    shipment_type "MyString"
  end
end
