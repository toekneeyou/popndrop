class Toilet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true
  validates :rate, presence: true
  validates :description, presence: true
  # validates :user_id, presence: true

  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  # has_attachment :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  mount_uploader :photo, PhotoUploader
end
