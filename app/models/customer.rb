class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province, optional: true
  has_many :orders
  
  validates :first_name, :last_name, :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "first_name", "id", "last_name", "phone", "province_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end