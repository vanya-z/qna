# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    user nil
    provider "MyString"
    uid "MyString"
    confirmation_token nil
    confirmation_token_sent_at nil
    confirmed_at nil
  end
end
