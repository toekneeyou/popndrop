class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true
end
