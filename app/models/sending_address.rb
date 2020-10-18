class SendingAddress < ApplicationRecord
  belongs_to :user

  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :prefecture_code, :city, :house_number, presence: true
  validates :post_code, presence: true, format: {with: /\A[0-9-]{,8}\z/}
  validates :phone_number, format: {with: /\A[0-9-]{,14}\z/}
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture_code
end
