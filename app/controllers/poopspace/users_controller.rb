class Poopspace::UsersController < ApplicationController
  def index
    @toilets = current_user.toilets
    @bookings = current_user.bookings
  end

  def show
    @toilet = Toilet.new
    @user = User.find(params[:id])
    @toilets = @user.toilets
    @bookings = Booking.select do |booking|
      booking.user_id == current_user.id
    end
    @upcoming_bookings = Booking.select do |booking|
    booking.toilet.user_id == current_user.id

    end

    @reviews_as_guest = Review.where(reviewable: @user)
    # finds all reviews where reviewable_type = "User", and reviewable_id = @user's user_id
    @reviews_as_host = Review.where(reviewable: host_bookings)
    @review_count = @reviews_as_host.count + @reviews_as_guest.count
    @all_reviews = @reviews_as_host + @reviews_as_guest
  end

  private

  def host_toilet_ids
    host_toilet_ids = []
    @user.toilets.each do |toilet|
      host_toilet_ids << toilet.id
    end
    host_toilet_ids
  end

  def host_bookings
    @hosts_bookings = Booking.select do |booking|
      host_toilet_ids.select do |toilet_id|
        booking.toilet_id == toilet_id
      end
    end
  end

end
