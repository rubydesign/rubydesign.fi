# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  #minimal product
  factory :product do
    sequence( :name) { |n| "product #{n}" }
    sequence :price , 10
    inventory 5
    factory :product_line do
      after(:create) do |prod| 
        create :product , :product_id => prod.id
      end
    end
    factory :product_without_inventory do
      inventory 0
    end
  end
end
