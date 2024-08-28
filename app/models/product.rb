class Product < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :orders, through: :order_products
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { greather_than_or_equal_to: 0 }

  csv_importer :name, :price, :quantity, :category
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  def self.my_import(file)
    products = []
    CSV.foreach(file.path, headers: true) do |row|
      products << Product.new(row.to_h)
    end
    Product.import products, recursive: true
  end
end
