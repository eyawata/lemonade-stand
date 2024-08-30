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

# urls = {
#   "Spotty Cup" => "https://res.cloudinary.com/djqladxhq/image/upload/v1724887832/production/37xd7p8imi78sjsz9ybvbo59gz6l.jpg",
#   "Northern Lights Planter" => "https://res.cloudinary.com/djqladxhq/image/upload/v1724887832/production/37xd7p8imi78sjsz9ybvbo59gz6l.jpg",
#   "Aurora Cup" => "https://res.cloudinary.com/djqladxhq/image/upload/v1724887832/production/37xd7p8imi78sjsz9ybvbo59gz6l.jpg"
# }

# items = [
#   "Spotty Cup",
#   "Northern Lights Planter",
#   "Aurora Cup"
# ]

# User seeds #
puts "Creating user seed"
if User.any?
  user = User.last
  user.update(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
else
  user = User.create!(email: "team@gmail.com", password: "123456", shop_name: "Lemonade Stand")
end

puts "Created/Updated account: #{user.email}"

# Product seeds #
puts "Creating products"

# items.each do |item|
#     product = user.products.create!(
#       name: item,
#       price: rand(1500..3000),
#       category: item.include?("Cup") ? "Cup" : "Planter",
#       quantity: rand(20..40)
#     )
#     p url = urls[product.name]
#     file = URI.open(url)
#     product.photo.attach(io: file, filename: "#{item}.jpeg", content_type: 'image/jpeg')
# end
# puts "Created #{user.products.count} products"

user.products.create!(
      name: "Aurora Mug",
      price: rand(1500..3000),
      category: "Mug",
      quantity: rand(20..40),
    )
user.products.last.photo.attach(
  io: File.open(Rails.root.join('app/assets/images/products/auroramug.jpg')),
  filename: 'auroramug.jpg',
  content_type: 'image/jpg'
)

user.products.create!(
      name: "Swirl Plate",
      price: rand(1500..3000),
      category: "Plate",
      quantity: rand(20..40),
    )
user.products.last.photo.attach(
  io: File.open(Rails.root.join('app/assets/images/products/swirlplate.jpg')),
  filename: 'swirlplate.jpg',
  content_type: 'image/jpg'
)


user.products.create!(
      name: "Spotty Bowl",
      price: rand(1500..3000),
      category: "Bowl",
      quantity: rand(20..40),
    )
user.products.last.photo.attach(
  io: File.open(Rails.root.join('app/assets/images/products/spottybowl.jpg')),
  filename: 'spottybowl.jpg',
  content_type: 'image/jpg'
)


# Orders #
puts "Creating orders!"
15.times do
  user.orders.create!(
    total_price: 0
  )
end
puts "Created #{user.orders.count} orders!"

total_orders = user.orders.count
orders_except_last = user.orders.limit(total_orders - 1)

# Order_products #
puts "Creating order_products for all orders except the last!"

orders_except_last.each do |order|
  1..2.times do
    @product = user.products.sample
    # if order already has sampled product, then add qty to that op
    if order.products.include?(@product)
      product_to_add = order.order_products.find_by(product: @product)
      product_qty = product_to_add.product_quantity
      product_to_add.update(product_quantity: product_qty += 1)
      order.update(total_price: order.subtotal)
    else
      # else create a new op for the order
      order.order_products.create!(
          product: @product,
          product_quantity: 1,
          product_price_at_sale: @product.price
        )
      order.update(total_price: order.subtotal)
    end
  end
end
puts "Created #{user.order_products.count} order_products!"

puts "Adding completed status to all orders except last"

orders_except_last.each do |order|
  order.update(status: "completed")
end

puts "Completed updating status"

# Events Seeds

puts "Creating event!"

user.events.create!(
    event_name: "Koenji Art Market",
    estimated_event_cost: 25000,
    start_date: Date.today - 7,
    end_date: Date.today - 4,
    location: "3-48-8 Horinouchi, Suginami-ku, Tokyo 166-0013"
  )

puts "Created #{user.events.last.event_name} event"

puts "Updating dates for orders..."

event = user.events.last
event_days = (event.start_date..event.end_date).to_a

# segment past orders and change their timestamps

orders_except_last[0..5].each do |order|
  order_date = event_days[0]
  order.update(updated_at: order_date, created_at: order_date)
end

orders_except_last[6..10].each do |order|
  order_date = event_days[1]
  order.update(updated_at: order_date, created_at: order_date)
end

orders_except_last[11..(orders_except_last.size - 1)].each do |order|
  order_date = event_days[2]
  order.update(updated_at: order_date, created_at: order_date)
end

puts "Changed the dates for all completed orders!"

event.assign_to_event_seeds

puts "Event now has relevant orders assigned correctly!"
