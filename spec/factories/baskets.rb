# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :basket do
    sequence(:id)
    factory :basket_with_item do
      items {build_list :item , 1 }
    end
    factory :basket_2_items do
      items  {[FactoryGirl.create(:item2) , FactoryGirl.create(:item22)]}
    end
    factory :basket_3_items do
      items {build_list :item_quantity , 3 }
    end
  end
end
