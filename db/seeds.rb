require 'open-uri'
require 'nokogiri'
require 'faker'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Updating user and deleting all products"
Product.destroy_all

urls = {
  "Blue Pot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125280/pexels-cottonbro-9120824_fqyjil.jpg",
  "Yellow Ceramic Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125636/pexels-ron-lach-8767270_iaioqq.jpg",
  "White Ceramic Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125704/pexels-roman-odintsov-8063806_ijdijd.jpg",
  "Purple Floral Ceramic Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125280/pexels-sunsetoned-5913195_dglwtr.jpg",
  "Grey Short Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125461/pexels-pnw-prod-8251590_c2ll4r.jpg",
  "Shell and Handmade Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125280/pexels-dagmara-dombrovska-22732579-26614928_q9iovk.jpg"
}

items = ["Blue Pot", "Yellow Ceramic Vase", "White Ceramic Vase", "Purple Floral Ceramic Teapot", "Grey Short Vase", "Shell and Handmade Vase"]

puts "Creating user seed"

user = User.last
user.update(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")

puts "Creating products"

items.each do |item|
  product = Product.create!(
      name: item,
      price: rand(1000..6000),
      category: item.include?("Vase") ? "Vase" : "Pot",
      quantity: rand(5..10),
      user: user
    )
  url = urls[product.name]
  file = URI.open(url)
  product.photo.attach(io: file, filename: "#{item}.jpeg", content_type: 'image/jpeg')
end

puts "Created #{Product.count} products"
