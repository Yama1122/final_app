class ProductImage < ApplicationRecord
  # product_imageのカラム名をmount_uploaderに指定する
  mount_uploader :url, ImageUploader
  belongs_to :product
end
