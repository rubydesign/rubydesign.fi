# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "Gourmet#{n}"}
    sequence(:link) {|n| "gourmet#{n}"}
  end
end
