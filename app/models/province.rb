class Province < ApplicationRecord
  has_many :customers
  validates :name, presence: true, uniqueness: true
end