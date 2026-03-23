class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, :unit_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end