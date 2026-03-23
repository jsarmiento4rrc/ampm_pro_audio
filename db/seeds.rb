require 'faker'

puts "Clearing old data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Customer.destroy_all

puts "Creating Categories..."
categories = ["DJ Controllers", "Studio Monitors", "Mixers", "Headphones", "Microphones", "Synthesizers", "Turntables", "PA Systems"]
categories.each { |name| Category.create!(category_name: name) }

puts "Creating Products..."
Category.all.each do |category|
  10.times do
    Product.create!(
      category: category,
      product_name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      price: Faker::Commerce.price(range: 50.0..2500.0),
      stock_quantity: rand(1..50)
    )
  end
end

puts "Creating Customers..."
50.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address
  )
end

puts "Creating Orders and Order Items..."
Customer.all.each do |customer|
  order = Order.create!(
    customer: customer,
    order_date: Faker::Date.backward(days: 30),
    total_amount: 0,
    status: ["Pending", "Processing", "Shipped", "Delivered"].sample
  )

  order_total = 0
  rand(1..3).times do
    product = Product.all.sample
    quantity = rand(1..2)
    unit_price = product.price

    OrderItem.create!(
      order: order,
      product: product,
      quantity: quantity,
      unit_price: unit_price
    )
    order_total += (quantity * unit_price)
  end

  order.update!(total_amount: order_total)
end

puts "Seeding complete!"
puts "Total records created: #{Category.count + Product.count + Customer.count + Order.count + OrderItem.count}"