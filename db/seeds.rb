Province.destroy_all

Province.create!([
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
])