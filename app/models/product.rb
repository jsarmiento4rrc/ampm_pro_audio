class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  
  has_one_attached :image
  
  validates :product_name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "product_name", "stock_quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment", "image_blob", "order_items"]
  end
end