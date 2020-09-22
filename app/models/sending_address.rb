class SendingAddress < ApplicationRecord
  belongs_to :user

  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :post_code, :prefecture_code, :city, :house_number, presence: true
end
