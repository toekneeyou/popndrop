class Poopspace::UsersController < ApplicationController
  def index
    @toilets = current_user.toilets
    @bookings = current_user.bookings
  end

  def show
    @toilets = Toilet.select do |toilet|
      toilet.user_id == current_user.id
    end
    @bookings = Booking.select do |booking|
      booking.user_id == current_user.id
    end
    @toilet = Toilet.new
    @user = User.find(params[:id])
  end
end
