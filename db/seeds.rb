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
  "White Ceramic Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145340/pexels-n-voitkevich-9863583_rzulg6.jpg",
  "Yellow Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145335/pexels-daria-liudnaya-7354520_whvh9g.jpg",
  "White Ceramic Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145337/pexels-karolina-grabowska-4219038_lkx9cr.jpg",
  "Glass Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145752/pexels-anna-pou-8330319_kpr2zx.jpg",
  "Shell and Handmade Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724156722/pexels-karolina-grabowska-6958755_z8j4hx.jpg",
  "Grey Short Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724125280/pexels-cup-of-couple-7302795_jiovse.jpg",
  "White Rounded Vase" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-karolina-grabowska-4207892_a5bklk.jpg",
  "Black Short Japanese Teapot" => "https://res.cloudinary.com/dxarsyyur/image/upload/v1724145336/pexels-eva-bronzini-6945183_v5osvh.jpg"
}

items = [
  "Blue Pot",
  "Yellow Ceramic Vase",
  "White Ceramic Teapot",
  "Yellow Vase",
  "White Ceramic Vase",
  "Glass Teapot",
  "Shell and Handmade Vase",
  "Grey Short Vase",
  "White Rounded Vase",
  "Black Short Japanese Teapot"
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
      total_price: rand(500..2000)
    )
  end
end
puts "Created #{Order.count} orders!"

# Order_products #
puts "Creating order_products!"
Order.all.each do |order|
  1..3.times do
    @product = Product.all.sample
    # if order already has sampled product, then add qty to that op
    if order.products.include?(@product)
      product_to_add = order.order_products.find_by(product: @product)
      product_qty = product_to_add.product_quantity
      product_to_add.update(product_quantity: product_qty += 1)
    else
      # else create a new op for the order
      order.order_products.create!(
          product: @product,
          product_quantity: 1,
          product_price_at_sale: @product.price
        )
    end
  end
end
puts "Created #{OrderProduct.count} order_products!"

puts "Adding random status to orders"

total_orders = Order.count
orders_except_last = Order.limit(total_orders - 1)

orders_except_last.each do |order|
  order.update(status: "completed")
end

# Events Seeds

puts "Completed updating status"
events = [
  "Clay Creations Expo",
  "Pottery Passion Fest",
  "Ceramic Art Showcase",
  "Wheel Throwing Workshop",
  "Glaze & Fire Festival"
]

puts "Creating events!"

start_date = Date.today - 5
end_date = Date.today - 10

events.each do |event|
  Event.create!(
    event_name: event,
    user: user,
    estimated_event_cost: rand(20..500),
    start_date: start_date,
    end_date: end_date
  )

  # Adjust the start_date and end_date for the next event
  start_date -= 5
  end_date -= 5
end

puts "Created #{Event.count} events"
