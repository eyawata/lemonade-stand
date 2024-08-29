class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_quantity, presence: true
  validates :product_price_at_sale, presence: true
  # validates :product_quantity, numericality: { greater_than_or_equal_to: 0 }
end
