# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :admin_user do
    name 'Admin User'
    email 'torsten@villataika.fi'
    password 'password'
    password_confirmation 'password'
  end

end
