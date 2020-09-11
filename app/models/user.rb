class User < ApplicationRecord
  has_many :comments
  has_many :favorites
  has_many :products, dependent: :destroy
  has_one  :sending_adress, dependent: :destroy
  has_one  :credit_card, dependent: :destroy
  has_many :seller_products, foreign_key:"seller_id" ,class_name:"products"
  has_many :buyer_products, foreign_key:"buyer_id" ,class_name: "products"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
