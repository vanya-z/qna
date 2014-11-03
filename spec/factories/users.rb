# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  
  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
    confirmed_at '2014-10-29 06:10:30'
    admin nil
  end
end
