# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    quantity 1
    price 10
    tax 5
    product
    factory :item2 do
      price 20
      factory :item22 do
        quantity 2
        tax 10
      end
    end
  end
end
