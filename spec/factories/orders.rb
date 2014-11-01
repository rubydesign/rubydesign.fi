# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence( :email) { |n| "test#{n}@test.com" }
    shipment_tax 0
    basket
  end
end
