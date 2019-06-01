# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence( :email) { |n| "test#{n}@test.com" }
    ordered_on Date.today
    shipment_tax 0
    basket { create :basket_with_item }
    factory :order_ordered do
      after(:create) do |o|
        o.generate_order_number
        o.save
      end
      ordered_on "2013-12-26"
      factory :order_paid do
        paid_on "2013-12-26"
      end
      factory :order_shipped do
        shipped_on "2013-12-26"
        shipment_price 10.0
        shipment_tax 20.0
        after(:create) do |o|
          o.basket.locked = Date.today
          o.save
        end
      end
    end
  end
end
