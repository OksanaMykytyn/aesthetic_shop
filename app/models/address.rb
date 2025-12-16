class Address < ApplicationRecord
  belongs_to :user
  validates :recipient_name, :phone, :city, :street, presence: true
end
