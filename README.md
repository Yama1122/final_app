## Users table

|Column|Type|Options|
|:---|:---|:---|
|nickname|string|null:false|
|email|string|null:false, unique: true|
|password|string|null:false|


## Association

* has_many :comments
* has_many :favorites
* has_many :products ,through: :comments, dependent: destroy
* has_many :products, through: :favorites, dependent: :destroy
* has_one :profile, dependent: :destroy
* has_one :sending-adress, dependent: :destroy
* has_one :credit-card, dependent: :destroy
* has_many :seller_products, foreign_key:"seller_id" ,class_name:"products"
* has_many :buyer_products, foreign_key:"buyer_id" ,class_name: "products"

***

## Profiles

|Column|Type|Options|
|:---|:---|:---|
first-name|string|null:false|
family-name|	string|	null:false|
first-name-kana|	string|	null:false|
family-name-kana|	string|	null:false|
birth-year|	date|	null:false|
birth-month|	date|	null:false|
birth-day|	date|	null:false|
image|	string|	
introduction|	text|	
user_id|	references|	foreign_key: true|

## Asociation

* belongs_to :user

***

## sending-adress

|Column|Type|Options|
|:---|:---|:---|
first-name|	string|	null: false
family-name|	string|	null: false
first-name-kana|	string|	null: false
family-name-kana|	string|	null: false
post-code|	integer(7)|	null:false
prefecture-code|	integer|	null:false
city|	string|	null:false
house-number|	string|	null:false
building-name|	string	
phone-number|	integer|	unique: true
user_id|	references|	 foreign_key: true

## Asociation

* belongs_to :user
* Gem：jp_prefecture

***

## credit_cards table

|Column|Type|Options|
|:---|:---|:---|
card-number|	integer|	null:false, unique: true
period-year|	integer|	null:false
period-month|	integer|	null:false
security-code|	integer| null:false
user_id|	references|	 foreign_key: true

## Asociation

* belongs_to :user

***

## Products table

|Column|Type|Options|
|:---|:---|:---|
name|	string|	null: false
profile|	text|	null: false
price|	integer|	null: false
product-image_id|	references|	 foreign_key: true
category_id|	references|	 foreign_key: true
brand_id|	references|	foreign_key: true
size_id|	references|	 foreign_key: true
condition_id|	references|	foreign_key: true
sending-day_id| references| foreign_key: true
postage_id|	references|	foreign_key: true
prefecture_code|	integer|	null: false
sending-type_id| references| foreign_iey: true
seller_id|	references|	null: false, foreign_key: true
buyer_id|	references|	foreign_key: true
deal_closed_day|	timestamp	


## Asociation

* has_many :comments, dependent: :destroy
* has_many :product-images, dependent: :destroy
* has_many :favorites
* has_many :users,through: :comments,dependent: :destroy
* has_many :users,through: :favorites,dependent: :destroy
* belongs_to :brand
* belongs_to :category
* belongs_to_active_hash :size
* belongs_to_active_hash :condition
* belongs_to_active_hash :sending-day
* belongs_to_active_hash :postage
* belongs_to_active_hash :sending_type
* belongs_to :seller, class_name: "User"
* belongs_to :buyer, class_name: "User"
* Gem：jp_prefecture

***



## brands table

|Column|Type|Options|
|:---|:---|:---|
name|	string

## Asociation

* has_many :products

***


## product-images table

|Column|Type|Options|
|:---|:---|:---|
product_id|	references|	foreign_key: true
url|	string|	null: false


## Asociation

* belongs_to :products

***


## favorites table

|Column|Type|Options|
|:---|:---|:---|
user|	references|	 foreign_key: true
product|	references|	 foreign_key: true


## Asociation

* belongs_to :user
* belongs_to :product


***

## comments table

|Column|Type|Options|
|:---|:---|:---|
comment|	text|	null: false
user_id|	references|	 foreign_key: true
product_id|	references|	 foreign_key: true
created_at|	timestamp|	null: false


## Asociation

* belongs_to :user
* belongs_to :product

***


## Categories table

|Column|Type|Options|
|:---|:---|:---|
name|	string|	null:false
ancestry|	string|	null:false


## Asociation

* has_many :products
