# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence( :email) { |n| "test#{n}@test.com" }
    shipment_tax 0
    basket { create :basket_with_item }
    factory :order_ordered do
      ordered_on "2013-12-26"
      factory :order_paid do
        paid_on "2013-12-26"
      end
    end
  end
end
