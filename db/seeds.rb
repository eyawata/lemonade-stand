require 'open-uri'
require 'nokogiri'
require 'faker'

puts "Deleting all order_products"
OrderProduct.destroy_all
puts "Updating and deleting all orders"
Order.destroy_all
puts "Updating user and deleting all products"
Product.destroy_all
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
  "Yellow Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145335/pexels-daria-liudnaya-7354520_whvh9g.jpg",
  "White Rounded Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-karolina-grabowska-4207892_a5bklk.jpg",
  "Orange Round Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145341/pexels-makaroff-aleksandr-114409006-10401476_rsrapc.jpg",
}

items = [
  "Blue Pot",
  "Yellow Ceramic Vase",
  "White Ceramic Vase",
  "Purple Floral Ceramic Teapot",
  "Grey Short Vase",
  "Shell and Handmade Vase",
  "White Ceramic Teapot",
  "Yellow Vase",
  "White Rounded Vase",
  "Orange Round Vase"
]

# User seeds #
puts "Creating user seed"
if User.any?
  user = User.last
  user.update(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
else
  user = User.create!(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
end
puts "Created #{User.count} user"

# Product seeds #
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
    product.photo.attach(io: file, filename: "#{item}.jpeg", content_type: 'image/jpeg')
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

# Orders #
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

# Order_products #
puts "Creating order_products!"
Order.all.each do |order|
  1..3.times do
    @product = Product.all.sample
    order.order_products.create!(
        product: @product,
        product_quantity: 1,
        product_price_at_sale: @product.price
      )
  end
end
puts "Created #{OrderProduct.count} order_products!"

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
