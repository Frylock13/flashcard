FactoryGirl.define do
  factory :card do
    origin_text "apple"
    translated_text  "яблоко"
    review_date Date.today
    user_id 1
  end

  factory :user do
    email "example@gmail.com"
    password  "pass"
    password_confirmation "pass"
    crypted_password "pass"
  end
end
