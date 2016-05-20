class Camera < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :users, through: :bookings
  has_attachment :photo
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


  def available?(user_start_date, user_end_date)
    if user_start_date.blank? || user_end_date.blank?
      return true
    else
      user_start_date = Date.new(("20" + user_start_date[6..-1]).to_i, user_start_date[3..4].to_i, user_start_date[0..1].to_i)
      user_end_date = Date.new(("20" + user_end_date[6..-1]).to_i, user_end_date[3..4].to_i, user_end_date[0..1].to_i)
      self.bookings.each do |booking|
        booking_start_date = Date.new(("20" + booking.start_date[6..-1]).to_i, booking.start_date[3..4].to_i, booking.start_date[0..1].to_i)
        booking_end_date = Date.new(("20" + booking.end_date[6..-1]).to_i, booking.end_date[3..4].to_i, booking.end_date[0..1].to_i)
        dates_range = (booking_start_date..booking_end_date)
        return false if dates_range.include?(user_start_date)
        return false if dates_range.include?(user_end_date)
        return false if user_start_date < booking_start_date && user_end_date > booking_end_date
      end
      return true
    end
  end
end


