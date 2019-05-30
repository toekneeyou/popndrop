class Booking < ApplicationRecord
  belongs_to :toilet
  belongs_to :user
  has_many :reviews, as: :reviewable

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :price, presence: true
end
