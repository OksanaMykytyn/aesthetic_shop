class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, length: { maximum: 1000 }, allow_blank: true

  after_commit :recalculate_product_rating

def recalculate_product_rating
  product.update!(
    rating_avg: product.reviews
      .where(approved: true)
      .average(:rating)
  )
end

end
