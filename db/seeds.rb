puts "Clearing old data..."
Product.destroy_all
Category.destroy_all
Province.destroy_all

puts "Creating Provinces with Tax Rates..."
provinces = [
  { name: 'Alberta', pst: 0.0, gst: 0.05, hst: 0.0 },
  { name: 'British Columbia', pst: 0.07, gst: 0.05, hst: 0.0 },
  { name: 'Manitoba', pst: 0.07, gst: 0.05, hst: 0.0 },
  { name: 'New Brunswick', pst: 0.0, gst: 0.0, hst: 0.15 },
  { name: 'Newfoundland and Labrador', pst: 0.0, gst: 0.0, hst: 0.15 },
  { name: 'Northwest Territories', pst: 0.0, gst: 0.05, hst: 0.0 },
  { name: 'Nova Scotia', pst: 0.0, gst: 0.0, hst: 0.15 },
  { name: 'Nunavut', pst: 0.0, gst: 0.05, hst: 0.0 },
  { name: 'Ontario', pst: 0.0, gst: 0.0, hst: 0.13 },
  { name: 'Prince Edward Island', pst: 0.0, gst: 0.0, hst: 0.15 },
  { name: 'Quebec', pst: 0.09975, gst: 0.05, hst: 0.0 },
  { name: 'Saskatchewan', pst: 0.06, gst: 0.05, hst: 0.0 },
  { name: 'Yukon', pst: 0.0, gst: 0.05, hst: 0.0 }
]

provinces.each do |prov|
  Province.create!(prov)
end

puts "Creating Categories..."
cat_microphones = Category.create!(category_name: 'Microphones')
cat_mixers      = Category.create!(category_name: 'Mixers')
cat_speakers    = Category.create!(category_name: 'Speakers')
cat_accessories = Category.create!(category_name: 'Accessories')

puts "Creating Products..."
products = [
  { 
    product_name: "Shure SM7B", 
    description: "Legendary vocal microphone for broadcast, podcast, and studio recording. Smooth, flat, wide-range frequency response.", 
    price: 539.00, 
    stock_quantity: 15,
    category: cat_microphones 
  },
  { 
    product_name: "Rode PodMic", 
    description: "Broadcast-quality dynamic microphone optimized for podcasting and vocal applications.", 
    price: 129.00, 
    stock_quantity: 42,
    category: cat_microphones 
  },
  { 
    product_name: "Pioneer DJ DJM-A9", 
    description: "Next-generation professional 4-channel DJ mixer with stunningly clear sound quality and enhanced effects.", 
    price: 3699.00, 
    stock_quantity: 4,
    category: cat_mixers 
  },
  { 
    product_name: "Allen & Heath Xone:96", 
    description: "Uncompromising analog DJ mixer with dual 32-bit USB soundcards and legendary Xone VCF filters.", 
    price: 2899.00, 
    stock_quantity: 7,
    category: cat_mixers 
  },
  { 
    product_name: "QSC K12.2", 
    description: "2000W 12-inch powered active speaker offering incredible audio performance and rugged durability.", 
    price: 1299.00, 
    stock_quantity: 12,
    category: cat_speakers 
  },
  { 
    product_name: "KRK Rokit 5 G4", 
    description: "5-inch powered nearfield studio monitor with DSP-driven Graphic EQ and Kevlar drivers.", 
    price: 249.00, 
    stock_quantity: 24,
    category: cat_speakers 
  },
  { 
    product_name: "Pro Co 20ft XLR Cable", 
    description: "Heavy-duty 20-foot XLR microphone cable built for stage and studio reliability.", 
    price: 29.99, 
    stock_quantity: 100,
    category: cat_accessories 
  },
  { 
    product_name: "On-Stage Speaker Stands", 
    description: "Pair of heavy-duty aluminum tripod speaker stands with carrying bag. Supports up to 120 lbs.", 
    price: 89.99, 
    stock_quantity: 30,
    category: cat_accessories 
  }
]

products.each do |prod|
  Product.create!(prod)
end

puts "Seeding complete! Created #{Category.count} categories, #{Product.count} products, and #{Province.count} provinces."


puts "Creating Admin User..."
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

puts "Creating CMS Pages..."
Page.find_or_create_by!(title: 'About Us') do |page|
  page.content = "Welcome to AMPM Pro Audio. We provide premium audio equipment for DJs, producers, and audio professionals."
end

Page.find_or_create_by!(title: 'Contact') do |page|
  page.content = "Have questions about our gear? Email us at support@ampmproaudio.com or call us directly."
end