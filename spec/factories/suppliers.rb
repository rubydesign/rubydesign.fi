# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supplier do
    name "MyString"
    association :address, :strategy => :build
  end
end
