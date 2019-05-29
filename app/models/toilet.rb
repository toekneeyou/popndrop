class Toilet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :rate, presence: true
  validates :description, presence: true
  # validates :user_id, presence: true

  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many :reviews, as: :reviewable
  # has_attachment :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
