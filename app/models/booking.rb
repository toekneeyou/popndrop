class Booking < ApplicationRecord
  belongs_to :toilet
  belongs_to :user
end
