class Event < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :photo

  validates :event_name, uniqueness: true
end
