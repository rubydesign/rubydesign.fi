# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    first_name "Me"
    last_name "Isdat"
    street1 "living here"
    postcode "111"
    country "Suomi"
  end
end
