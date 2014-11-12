FactoryGirl.define do
  factory :pack do
    name "Фрукты"
    user_id 1
  end

  factory :user do
    id 1
    pack_id 1
    email "user@gmail.com"
    password  "pass"
    password_confirmation "pass"
  end
end
