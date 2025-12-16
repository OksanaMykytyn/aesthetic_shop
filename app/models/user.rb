class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar

  has_many :carts, dependent: :destroy
  has_many :cart_items, through: :carts

  enum role: { client: "client", manager: "manager" }

  validates :first_name,
    presence: true,
    length: { in: 3..50 },
    format: { with: /\A[А-Яа-яA-Za-z]+\z/ }

  validates :last_name,
    presence: true,
    length: { in: 3..50 },
    format: { with: /\A[А-Яа-яA-Za-z]+\z/ }

  validates :password,
    presence: true,
    length: { in: 8..20 },
    format: {
      with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).+\z/
    }
end
