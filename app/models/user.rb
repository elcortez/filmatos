class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings, dependent: :nullify
  has_many :cameras, dependent: :destroy
  # devise validates itself everything?
  has_attachment :photo

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def number_of_pending_bookings
    number = 0
    if !self.cameras.empty?
      self.cameras.each do |camera|
        if !camera.bookings.empty?
          camera.bookings.each do |booking|
            if booking.status == 'pending'
              number += 1
            end
          end
        end
      end
    end
    number
  end

  def stats_as_renter
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

  def stats_as_owner
    sentence = "No history"
    nb_accepted = 0
    nb_total = 0
    if !self.cameras.empty?
      self.cameras.each do |camera|
        if !camera.bookings.empty?
          camera.bookings.each do |booking|
            nb_total += 1
            if booking.status == 'accepted'
              nb_accepted += 1
            end
          end
          percent = (nb_accepted.fdiv(nb_total) * 100).round
          sentence = "#{percent}%"
        end
      end
    end
    sentence
  end

  def sales
    sales = 0
    if !self.cameras.empty?
      self.cameras.each do |camera|
        if !camera.bookings.empty?
          camera.bookings.each do |booking|
            if booking.status == 'accepted'
              booking_start_date = Date.new(("20" + booking.start_date[6..-1]).to_i, booking.start_date[3..4].to_i, booking.start_date[0..1].to_i)
              booking_end_date = Date.new(("20" + booking.end_date[6..-1]).to_i, booking.end_date[3..4].to_i, booking.end_date[0..1].to_i)
              sales += (booking_end_date - booking_start_date) * camera.price
            end
          end
        end
      end
    end
    sales
  end
end
