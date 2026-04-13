class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, :price, presence: true

  # Whitelist attributes for ActiveAdmin/Ransack search
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end
end