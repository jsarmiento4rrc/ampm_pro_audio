class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items
  
  validates :status, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "order_date", "status", "total_amount", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "products"]
  end
end