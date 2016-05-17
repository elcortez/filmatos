class Camera < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  validates :brand, presence: true
  validates :category, presence: true, inclusion: { in: ["Camera", "Accessory", "Lense", "Tripod"]}
  validates :description, presence: true
  validates :price, presence: true

  scope :search_with_description, ->(term) { where("description iLIKE ? ", "%#{term}%") }
  scope :search_with_brand, ->(term) { where(brand: term) }
  # scope :search_with_brand, ->(term) { where("brand = ?", term) }
  scope :search_with_category, ->(term) { where(category: term) }
  # scope :search_with_category, ->(term) { where('category IN (?)', term) }
  scope :search_with_price, ->(min, max) { where('price >= ? AND price <= ?', min.to_i, max.to_i) }

  def self.categories
    select("DISTINCT category").collect(&:category)
  end

  def self.brands
    select("DISTINCT brand").collect(&:brand)
  end
end


