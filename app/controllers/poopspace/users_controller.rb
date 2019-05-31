class Poopspace::UsersController < ApplicationController
  def index
    @toilets = current_user.toilets
    @bookings = current_user.bookings
  end

  def show
    @toilets = User.find(params[:id]).toilets
    @bookings = Booking.select do |booking|
      booking.user_id == current_user.id
    end

    @toilet = Toilet.new
    @user = User.find(params[:id])
    @reviews = Review.where(reviewable: @user)

    @upcoming_bookings = Booking.select do |booking|
    booking.toilet.user_id == current_user.id

    end
    @review_count = @user.bookings.reduce(0) do |sum, booking|
      sum += booking.reviews.count unless booking.reviews.empty?
      sum
    end
  end
end
