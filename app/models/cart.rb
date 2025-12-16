class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  scope :active, -> { where(status: "active") }
end
