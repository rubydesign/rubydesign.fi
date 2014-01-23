# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :basket do
    sequence(:id)
    factory :basket_with_item do
      items {build_list :item , 1 }
    end
    factory :basket_with_items do
      items {build_list :item , 3 }
    end
  end
end
