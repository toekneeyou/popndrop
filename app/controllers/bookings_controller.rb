class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @booking = Booking.new
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = User.find(params[:user_id])
    @booking.toilet_id = Toilet.find(params[:toilet_id])
    # @booking.price = @booking.toilet_id.price * (@booking.check_out - @booking.check_in)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      @booking = Booking.new(booking_params)
      redirect_to bookings_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:name)
  end
end
