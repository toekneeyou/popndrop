class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  mount_uploader :photo, PhotoUploader
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniquness: true
  validates :encrypted_password, presence: true

  has_many :bookings
  has_many :reviews, throug: :bookings
end
