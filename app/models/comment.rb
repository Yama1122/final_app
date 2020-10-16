class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :body,                presence: true,  length: { maximum: 40 }
end
