# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clerk do
    sequence( :name) { |n| "Test Clerk#{n}" }
    sequence( :email) { |n| "test#{n}@test.com" }
    password 'password'
    password_confirmation 'password'
    # confirmed_at Time.now
    factory :admin do
      admin true
    end
  end
end
