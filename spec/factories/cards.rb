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
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret","asdasdastr4325234324sdfds")
  end
end
