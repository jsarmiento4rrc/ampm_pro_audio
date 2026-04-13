class Order < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  validates :status, presence: true
end