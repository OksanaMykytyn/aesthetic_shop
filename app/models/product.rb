class Product < ApplicationRecord
  belongs_to :category
  has_many :product_collections, dependent: :destroy
  has_many :collections, through: :product_collections
  has_many_attached :images
  has_many :cart_items
  has_many :order_items
  has_many :reviews

  validates :title, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
end
