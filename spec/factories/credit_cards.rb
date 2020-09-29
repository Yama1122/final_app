FactoryBot.define do
  factory :credit_card do
    id{1}
    customer_id{"cus_xxxxxxxxxxxxxx"}
    card_id{"car_yyyyyyyyyyyyyyy"} 
    association :user
  end
end
