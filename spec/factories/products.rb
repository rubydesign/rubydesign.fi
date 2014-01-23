# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  #minimal product
  factory :product do
    sequence( :name) { |n| "product #{n}" }
    sequence :price , 10
  end
end
