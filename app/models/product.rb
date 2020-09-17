class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :favorites
  has_many :users, dependent: :destroy
  belongs_to :brand, optional: true
  belongs_to :category
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true

  accepts_nested_attributes_for :product_images, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :sendingday
  belongs_to_active_hash :postage
  belongs_to_active_hash :sendingtype
end
