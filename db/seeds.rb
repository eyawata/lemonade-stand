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
# puts "Updating user and deleting all products"
# Product.destroy_all
# puts "Updating and deleting all orders"
# Order.destroy_all
puts "Updating and deleting all events"
Event.destroy_all

urls = {
  "Blue Pot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724159438/pexels-cottonbro-9120824_j07myx.jpg",
  "Yellow Ceramic Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724159511/pexels-ron-lach-8767270_aglkvs.jpg",
  "White Ceramic Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145337/pexels-karolina-grabowska-4219038_lkx9cr.jpg",
  "Purple Floral Ceramic Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724151922/755179536_max_wzmitq.jpg",
  "Grey Short Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125280/pexels-cup-of-couple-7302795_jiovse.jpg",
  "Shell and Handmade Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724156722/pexels-karolina-grabowska-6958755_z8j4hx.jpg",
  "White Ceramic Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145341/pexels-n-voitkevich-9863683_bjm8px.jpg",
  "Chinese Style Black Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-ivan-samkov-8952009_ipctno.jpg",
  "Yellow Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145335/pexels-daria-liudnaya-7354520_whvh9g.jpg",
  "White Rounded Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-karolina-grabowska-4207892_a5bklk.jpg",
  "Black Cup-shaped Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145335/pexels-cottonbro-4273435_icflf3.jpg",
  "Transparent Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145752/pexels-anna-pou-8330319_kpr2zx.jpg",
  "Black Ceramic Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-eva-bronzini-6945183_v5osvh.jpg",
  "Orange Round Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145341/pexels-makaroff-aleksandr-114409006-10401476_rsrapc.jpg",
  "Gray Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145341/pexels-marta-dzedyshko-1042863-3302499_zxuuym.jpg"
}

items = [
  "Blue Pot",
  "Yellow Ceramic Vase",
  "White Ceramic Vase",
  "Purple Floral Ceramic Teapot",
  "Grey Short Vase",
  "Shell and Handmade Vase",
  "White Ceramic Teapot",
  "Chinese Style Black Teapot",
  "Yellow Vase",
  "White Rounded Vase",
  "Black Cup-shaped Vase",
  "Transparent Teapot",
  "Black Ceramic Teapot",
  "Orange Round Vase",
  "Gray Vase"
]

# User seeds
puts "Creating user seed"
if User.any?
  user = User.last
  user.update(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
else
  user = User.create!(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
end
puts "Created #{User.count} user"

# Product seeds
puts "Creating products"
if Product.any?
  Product.all.each do |existing_product|
    if existing_product.photo.attached? == false
      url = urls[existing_product.name]
      file = URI.open(url)
      existing_product.photo.attach(io: file, filename: "#{existing_product.name}.jpeg", content_type: 'image/jpeg')
    end
  end
else
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
    product.photo.attach(io: file, filename:"#{item}.jpeg", content_type: 'image/jpeg')
  end
end

items.each do |item|
  if Product.exists?(name: item) == false
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
end
puts "Created #{Product.count} products"
# items.each do |item|
#   product = Product.update!(
#       name: item,
#       price: rand(1000..6000),
#       category: item.include?("Vase") ? "Vase" : "Pot",
#       quantity: rand(5..10),
#       user: user
#     )
#   url = urls[product.name]
#   file = URI.open(url)
#   product.photo.attach(io: file, filename: "#{item}.jpeg", content_type: 'image/jpeg')
# end
puts "Created #{Product.count} products"

# events = [
#   "Clay Creations Expo",
#   "Pottery Passion Fest",
#   "Ceramic Art Showcase",
#   "Wheel Throwing Workshop",
#   "Glaze & Fire Festival"
# ]

# puts "Creating events!"

# 5.times do
#   events.each do |event|
#     Event.create!(
#       event_name: event,
#       user: user
#   )
#   end
# end

# puts "Created #{Event.count} events"

# Orders
puts "Creating orders!"
if Order.any? == false
  5.times do
    Order.create!(
      total_price: rand(500..2000),
      status: rand(1..2)
    )
  end
end
puts "Created #{Order.count} orders!"

# Order_products
puts "Creating order_products!"

orders = Order.all
products = Product.all
order_products = OrderProduct.all

if OrderProduct.any?
  order_products.each do |order_product|
    orders.each do |order|
      if order_product.order == order
        order_product.update(
          product: products.first,
          product_quantity: 1,
          product_price_at_sale: products.first.price
        )
      else
        OrderProduct.create!(
          product: Product.first,
          product_quantity: 1,
          product_price_at_sale: Product.first.price
        )
      end
    end
  end
else
  OrderProduct.create!(
    product: Product.first,
    product_quantity: 1,
    product_price_at_sale: Product.first.price,
    order: Order.sample
  )
end
puts "Created #{OrderProduct.count} order_products!"

# Order.all.each do |order|
#   @product = Product.all.sample
#   order.order_products.update!(
#     product: @product,
#     product_quantity: 1,
#     product_price_at_sale: @product.price
#   )
# end

# choose a random product from all products
# choose a number between 0 and product.quantity
# for that random number, add it to a random order(?)
