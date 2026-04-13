class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Requirement 3.1.2: Association with Province for tax calculation
  belongs_to :province, optional: true

  # Requirement 3.2.1: Association with Orders
  # Added 'dependent: :destroy' so deleting a test user also clears their history
  has_many :orders, dependent: :destroy

  # Validations for registration fields (Requirement 4.1.2)
  validates :first_name, :last_name, :address, :phone, presence: true
  validates :email, presence: true, uniqueness: true

  # Helper method to display full name in Admin or Profile
  def full_name
    "#{first_name} #{last_name}"
  end
end