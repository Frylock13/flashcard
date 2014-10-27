FactoryGirl.define do
  factory :card do
    origin_text "apple"
    translated_text  "яблоко"
    review_date Date.today
    user_id 1
  end

  factory :user do
    id 1
    email "user@gmail.com"
    password  "pass"
    password_confirmation "pass"
  end
end
