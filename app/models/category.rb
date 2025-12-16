class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true
end
