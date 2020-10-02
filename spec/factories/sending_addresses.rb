FactoryBot.define do

  factory :sending_address do
    first_name            {"kkk"}
    first_name_kana       {"カタカナ"}
    family_name             {"kkk"}
    family_name_kana        {"カタカナ"}
    post_code             {"1234567"}
    prefecture_code            {"19"}
    city                 {"名古屋市中川区"}
    house_number              {"123"}
    user_id {"1"}
    
  end
end
