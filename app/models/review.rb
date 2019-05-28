class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  belongs_to :booking

  validates :content, presence: true
  validates :rating, presence: true
end
