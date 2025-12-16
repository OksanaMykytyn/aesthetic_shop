class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  enum status: { new_order: "new_order", processing: "processing", shipped: "shipped", completed: "completed", cancelled: "cancelled" }

  validates :number, presence: true, uniqueness: true
end
