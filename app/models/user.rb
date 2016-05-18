class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings
  has_many :cameras
  # devise validates itself everything?
  has_attachment :photo

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
