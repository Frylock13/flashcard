FactoryGirl.define do
  factory :card do
    origin_text "apple"
    translated_text  "яблоко"
    review_date Date.today
    right_repetition_count 0
    wrong_repetition_count 0
    guessed false
    user_id 1
    pack_id 1
  end
end
