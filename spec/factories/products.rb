# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    price 1.5
    cost 1.5
    weight 1.5
    name "MyString"
    description "MyText"
    link "MyString"
    ean "MyString"
    tax 1.5
    properties "MyString"
    scode "MyString"
    product nil
    product_group nil
    supplier nil
  end
end
