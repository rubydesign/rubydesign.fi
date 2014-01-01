# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    quantity 1
    price 1.5
    tax 1.5
    product_id 0
  end
end
