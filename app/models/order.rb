class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  
  validates :subtotal, :gst, :pst, :hst, :total, :status, presence: true
end