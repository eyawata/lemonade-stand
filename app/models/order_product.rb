class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_quantity, presence: true
  validates :product_price_at_sale, presence: true
end
