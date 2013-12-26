# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    name "MyString"
    ordered_on "2013-12-26"
    received_on_date "MyString"
    bucket nil
    supplier ""
  end
end
