# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "My comment"
    commentable_id 1
    commentable_type "MyString"
    user
  end
end
