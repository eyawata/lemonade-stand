class Product < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :orders, through: :order_products
  has_attached_one :photo

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { greather_than_or_equal_to: 0 }
end
