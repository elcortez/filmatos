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

  def stats
    if !self.bookings.empty?
      nb_accepted = 0
      nb_total = self.bookings.count
      self.bookings.each do |booking|
        nb_accepted += 1 if booking.status == 'accepted'
      end
      percent = (nb_accepted.fdiv(nb_total) * 100).round
      "#{percent}%"
    else
      "No history"
    end
  end

end
