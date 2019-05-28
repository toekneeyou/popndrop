class Toilet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :rate, presence: true
  validates :description, presence: true
  # validates :user_id, presence: true

  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  # has_attachment :photo
end
