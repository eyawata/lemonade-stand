class Event < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :photo

  validates :event_name, uniqueness: true

  def assign_to_event
    @order = Order.all
    @order.each do |order|
      if order.updated_at >= self.start_date.beginning_of_day && order.updated_at <= self.end_date.end_of_day
        order.update(event: self)
      else
        order.update(event: nil)
      end
    end
  end

  def assign_to_event_seeds
    orders_to_assign = Order.where('updated_at >= ? AND updated_at <= ?', self.start_date, self.end_date)
    orders_to_assign.update_all(event_id: self.id)
  end
end
