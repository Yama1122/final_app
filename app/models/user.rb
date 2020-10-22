class User < ApplicationRecord
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product
  has_many :products, dependent: :destroy
  has_one  :sending_address, dependent: :destroy
  has_one  :credit_card, dependent: :destroy
  has_many :seller_products, foreign_key:"seller_id" ,class_name:"products"
  has_many :buyer_products, foreign_key:"buyer_id" ,class_name: "products"
  accepts_nested_attributes_for :sending_address
  # 親モデルを通じてネストしたモデルの関連レコードの登録・更新を可能にする

  validates :nickname, :email, :family_name, :first_name, :birth_date, presence: true
  validates :first_name_kana, :family_name_kana, presence: true, 
            format: { with: /\A([ァ-ン]|ー)+\z/ }
  validates :password, presence: true, on: :create

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture_code
end
