class Order < ApplicationRecord
  belongs_to :event
  has_many :order_products
  has_many :products, through: :order_products

  validates :total_price, presence: true
  validates :status, presence: true
end
