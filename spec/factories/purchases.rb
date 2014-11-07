# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    sequence( :name) { |n| "purchase #{n}" }
    ordered_on "2013-12-26"
    received_on "2013-12-26"
    basket { create :basket_with_item }
  end
end
