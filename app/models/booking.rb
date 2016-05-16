class Booking < ActiveRecord::Base
  belongs_to :camera
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :camera, presence: true
  validates :user, presence: true
  # validates :camera, uniqueness: { scope: :start_date }
  # validate unicity of camera if start_date is
  # between start and end date of another instance
end
