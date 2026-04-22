puts "Clearing old data..."
Product.destroy_all
Category.destroy_all
Province.destroy_all

puts "Creating Provinces with Tax Rates..."
Province.create!([
  { name: "Alberta", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "New Brunswick", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Newfoundland and Labrador", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Nova Scotia", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Nunavut", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Ontario", gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: "Prince Edward Island", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: "Yukon", gst: 0.05, pst: 0.00, hst: 0.00 }
])

puts "Creating Categories..."
mics = Category.create!(name: "Microphones")
mixers = Category.create!(name: "Mixers")
speakers = Category.create!(name: "Speakers")
cables = Category.create!(name: "Cables")

puts "Creating Products..."

Product.create!([
  {
    product_name: "Shure SM7B",
    description: "Legendary vocal dynamic microphone, perfect for broadcasting, podcasting, and studio recording.",
    price: 529.00,
    category: mics
  },
  {
    product_name: "Rode NT1-A",
    description: "Large-diaphragm cardioid condenser microphone with an ultra-low noise floor.",
    price: 329.99,
    category: mics
  },
  {
    product_name: "Pioneer DJ DJM-A9",
    description: "Next-generation 4-channel professional DJ club mixer.",
    price: 3599.00,
    category: mixers
  },
  {
    product_name: "Yamaha MG10XU",
    description: "10-Input Stereo Mixer with built-in SPX digital effects and USB audio interface.",
    price: 289.50,
    category: mixers
  },
  {
    product_name: "QSC K12.2",
    description: "2000W 12-inch powered PA speaker with advanced DSP.",
    price: 1299.00,
    category: speakers
  },
  {
    product_name: "KRK Rokit 5 G4",
    description: "5-inch powered nearfield studio monitor.",
    price: 249.00,
    category: speakers
  },
  {
    product_name: "Mogami Gold Studio 15",
    description: "15-foot premium XLR microphone cable with Neutrik connectors.",
    price: 89.95,
    category: cables
  },
  {
    product_name: "Hosa Pro TRS Cable",
    description: "10-foot balanced interconnect cable, 1/4 inch TRS to 1/4 inch TRS.",
    price: 19.99,
    category: cables
  }
])

puts "Seeding complete! Created #{Category.count} categories, #{Product.count} products, and #{Province.count} provinces."