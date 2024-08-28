class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products
  has_many :order_products, through: :products
  has_many :orders
  has_many :orders, through: :order_products
  has_many :events

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
