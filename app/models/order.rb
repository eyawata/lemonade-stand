class Order < ApplicationRecord
  belongs_to :event, optional: true
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :user

  validates :total_price, presence: true
  validates :status, presence: true
  OPTIONS = ["incomplete", "completed"]
  validates :status, inclusion: { in: OPTIONS }

  def subtotal
    subtotal = 0
    self.order_products.each do |op|
      product_total = op.product_price_at_sale * op.product_quantity
      subtotal = subtotal + product_total
    end
    return subtotal
  end

  def update_inventory
    self.order_products.each do |op|
      qty_bought = op.product_quantity
      product_to_update = op.product
      qty_to_update = product_to_update.quantity
      product_to_update.update(quantity: qty_to_update - qty_bought)
    end
  end

  # def self.assign_to_event(event)
  #   orders_to_assign = where('created_at >= ? AND created_at <= ?', event.start_date, event.end_date)
  #   orders_to_assign.update_all(event_id: event.id)
  # end
end
