class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  
  # ActiveStorage association
  has_one_attached :image
  
  validates :product_name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Whitelist associations for ActiveAdmin/Ransack search
  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment", "image_blob", "line_items"]
  end

  # Whitelist attributes for ActiveAdmin/Ransack search
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "product_name", "stock_quantity", "updated_at"]
  end
end