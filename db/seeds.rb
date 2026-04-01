# 1. Destroy Join Tables and Children
LineItem.destroy_all
Order.destroy_all

# 2. Destroy Products before Categories
Product.destroy_all
Category.destroy_all

# 3. Destroy Customers before Provinces
Customer.destroy_all
Province.destroy_all

# 4. Destroy Admins
AdminUser.destroy_all

# 5. Create Admin User
puts "Creating Admin User..."
if Rails.env.development?
  AdminUser.create!(
    email: 'admin@example.com', 
    password: 'password', 
    password_confirmation: 'password'
  )
end

# 6. Create Provinces
puts "Creating Provinces..."
provinces = [
  { name: 'Alberta', gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: 'British Columbia', gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: 'Manitoba', gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: 'New Brunswick', gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: 'Newfoundland and Labrador', gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: 'Northwest Territories', gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: 'Nova Scotia', gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: 'Nunavut', gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: 'Ontario', gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: 'Prince Edward Island', gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: 'Quebec', gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: 'Saskatchewan', gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: 'Yukon', gst: 0.05, pst: 0.00, hst: 0.00 }
]

provinces.each do |province_data|
  Province.create!(province_data)
end

# 7. Create Categories
puts "Creating Categories..."
category_names = ['DJ Controllers', 'Mixers', 'Studio Monitors', 'Headphones']
categories = category_names.map do |name|
  Category.create!(category_name: name)
end

# 8. Create Products Safely
puts "Creating 80 Products..."
require 'faker'

80.times do |i|
  begin
    Product.create!(
      product_name: "#{Faker::Commerce.product_name} Model #{i + 1}",
      description: Faker::Lorem.paragraph(sentence_count: 4),
      price: Faker::Commerce.price(range: 50.0..2500.0),
      stock_quantity: rand(0..100), # This fulfills your model validation!
      category: categories.sample
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create product #{i + 1}: #{e.message}"
  end
end

puts "Database successfully seeded with #{Product.count} products!"