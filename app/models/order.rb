class Order < ApplicationRecord
  # belongs_to :event
  has_many :order_products
  has_many :products, through: :order_products

  validates :total_price, presence: true
  validates :status, presence: true

  enum status: [ :pending, :completed, :incomplete ]


  def subtotal
    subtotal = 0
    self.order_products.each do |op|
      product_total = op.product_price_at_sale * op.product_quantity
      subtotal = subtotal + product_total
    end
    return subtotal
  end
end
