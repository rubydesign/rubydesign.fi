# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :purchase do
    sequence( :name) { |n| "purchase #{n}" }
    basket { create :basket_with_item }
    after(:create) do |purchase|
      purchase.supplier = purchase.basket.items.first.product.supplier
    end
    factory :empty_purchase do
      after(:create) do |purchase|
        purchase.basket.items.clear
      end
    end
    factory :purchase_ordered do
      ordered_on {"2018-12-26"}
      factory :purchase_received do
        received_on {"2018-12-26"}
      end
    end
  end
end
