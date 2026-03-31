class Customer < ApplicationRecord
  has_many :orders
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "first_name", "id", "last_name", "phone", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end