FactoryBot.define do

  factory :user do
    first_name            {"kkk"}
    first_name_kana       {"カタカナ"}
    family_name             {"kkk"}
    family_name_kana        {"カタカナ"}
    nickname              {"abe"}
    birth_date            {"1940-08-16"}
    email                 {"kkk@email.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    
  end
end
