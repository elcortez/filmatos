class Review < ActiveRecord::Base
  belongs_to :camera
  validates :content, presence: true
  # validates :rating, presence: true
  validates :rating, inclusion: { in: [0, 1, 2, 3, 4, 5], allow_nil: false }
  validates :rating, numericality: { only_integer: true }
  validates :camera, presence: true
end
