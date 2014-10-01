# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    body "My answer"
    is_accepted false
    question
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    is_accepted false
    question
    user
  end
end
