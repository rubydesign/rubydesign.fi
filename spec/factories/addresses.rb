# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    first_name "MyString"
    last_name "MyString"
    street1 "MyString"
    street2 "MyString"
    postcode "MyString"
    country "MyString"
  end
end
