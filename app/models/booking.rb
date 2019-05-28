class Booking < ApplicationRecord
  belongs_to :toilet
  belongs_to :user
  has_one :review

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :price, presence: true
end
