FactoryGirl.define do
  factory :card do
    origin_text "apple"
    translated_text  "яблоко"
    review_date Date.today
    successful_repeat_count 0
    fail_repeat_count 0
    guesed false
    user_id 1
    pack_id 1
  end
end
