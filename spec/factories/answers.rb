# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body "My answer"
    question
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question
    user
  end
end
