class Camera < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  validates :brand, presence: true
  validates :category, presence: true, inclusion: { in: ["Camera", "Accessory", "Lense", "Tripod"]}
  validates :description, presence: true
  validates :price, presence: true

  scope :search, ->(term) { where("description iLIKE ? ", "%#{term}%") }
end
