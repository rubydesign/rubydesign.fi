# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    first_name "Torsten"
    last_name "Ruger"
    street1 "Fiskarsintie 513"
    city "10480 antskog"
    country "Suomi"
  end
end
