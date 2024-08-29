class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true
  has_many :order_products
  has_many :products, through: :order_products

  validates :total_price, presence: true
  validates :status, presence: true
  enum status: { incomplete: "incomplete" , completed: "completed"}

  def subtotal
    subtotal = 0
    self.order_products.each do |op|
      product_total = op.product_price_at_sale * op.product_quantity
      subtotal = subtotal + product_total
    end
    return subtotal
  end

  def update_inventory
    order_products.each do |op|
      qty_bought = op.product_quantity
      product_to_update = op.product
      qty_to_update = product_to_update.quantity
      product_to_update.update(quantity: qty_to_update - qty_bought)
    end
  end


  def process!
    return unless incomplete?

      # update_inventory is an instance method in order.rb
      update_inventory

      # mark order as complete and order's total price (inclusive of discount selected)
      discount = order_discount.to_i.fdiv(100) * subtotal
      total_price = subtotal - discount
      update(status: "completed", total_price: total_price)


      # create a new empty order
      last_order = Order.new(total_price: 0, user: user)
      last_order.save
      last_order

  end
  # def self.assign_to_event(event)
  #   orders_to_assign = where('created_at >= ? AND created_at <= ?', event.start_date, event.end_date)
  #   orders_to_assign.update_all(event_id: event.id)
  # end
  def assign_to_event(event)
    self.update(event_id: event.id)
  end
end
