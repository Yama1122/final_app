class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :favorites
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :sendingday
  belongs_to_active_hash :postage
  belongs_to_active_hash :sendingtype
  belongs_to_active_hash :prefecture_code
end
