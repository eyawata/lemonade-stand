require 'csv'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products
  has_many :order_products, through: :products
  has_many :orders
  has_many :events

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def my_import(file)
    products = []
    if params[:file].blank?
      flash[:notice] = "No file attached"
      redirect_to products_path
    else
      CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
        product = Product.new(name: row[:name], price: row[:price], category: row[:category], quantity: row[:quantity])
        product.user = self
        product.valid?
        product.save

        file = URI.open(row[:image_url])
        product.photo.attach(io: file, filename: "#{product.name}.jpg", content_type: 'image/jpg')
        products << product
      end
    end
  end
end
