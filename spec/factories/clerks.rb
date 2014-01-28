# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clerk do
    name 'Test Clerk'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
    # confirmed_at Time.now
  end

  factory :admin_clerk do
    name 'Admin Clerk'
    email 'torsten@villataika.fi'
    password 'password'
    password_confirmation 'password'
  end

end
