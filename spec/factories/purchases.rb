# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    sequence( :name) { |n| "purchase #{n}" }
    basket { create :basket_with_item }
    factory :purchase_ordered do
      ordered_on "2013-12-26"
      factory :purchase_received do
        received_on "2013-12-26"
      end
    end
  end
end
