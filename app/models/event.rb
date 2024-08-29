class Event < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :photo

  validates :event_name, uniqueness: true

  def assign_to_event
    orders_to_assign = Order.where('updated_at >= ? AND updated_at <= ?', self.start_date.beginning_of_day, self.end_date.end_of_day)
    orders_to_assign.update_all(event_id: self.id)
  end
end
