# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    price 10
    name "prod"
#    link "prod"
    tax 23
  end
end
