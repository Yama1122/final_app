FactoryBot.define do
  factory :product do
    name                 {"test"}
    profile              {"test000"}
    price                {"10000"}
    category             {"メンズ"}
    condition_id         {"1"}
    sendingday_id        {"1"}
    postage_id           {"1"}
    prefecture_code_id   {"1"}
    sendingtype_id       {"1"}
    seller_id            {"1"}
    after(:build) do |product|
      product.images << build(:image, product: product)
    end
    user
  end
end
