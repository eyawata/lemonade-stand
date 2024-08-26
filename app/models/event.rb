class Event < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :photo

  validates :event_name, uniqueness: true

  def assign_to_event
    orders_to_assign = Order.where('updated_at >= ? AND updated_at <= ?', self.start_date, self.end_date)
    orders_to_assign.update_all(event_id: self.id)
  end
end
