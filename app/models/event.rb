class Event < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :event_name, uniqueness: true
end
