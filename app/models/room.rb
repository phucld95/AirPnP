class Room < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}
  belongs_to :user
  has_many :photos
  has_many :reservations

  has_many :reviews
  has_many :calendars

  geocoded_by :address
  # Whenever address change, geocode will be updated
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true

  def cover_photo size
    if self.photos.length > 0
      self.photos[0].image.url size
    else
      "blank.jpg"
    end
  end

  def average_rating
    if reviews.average(:star).present?
      reviews.count == 0 ? 0 : reviews.average(:star).round(2).to_i
    else
      return 0
    end
  end
end
