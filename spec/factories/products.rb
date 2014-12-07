# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  #minimal product
  factory :product do
    sequence( :name) { |n| "product #{n}" }
    price 10
    tax 10.0
    inventory 5
    factory :shop_product do
      online true
      after(:create) do |prod|
        cat = create :category , :online => true
        prod.category = cat
        prod.save!
      end
    end
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
