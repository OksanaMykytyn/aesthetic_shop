class Collection < ApplicationRecord
  has_many :product_collections, dependent: :destroy
  has_many :products, through: :product_collections
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true
end
