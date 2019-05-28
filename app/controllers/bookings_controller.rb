class BookingsController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user.id)
    @review = Review.new
  end

  def show
    set_booking
    @toilet = @booking.toilet
  end

  def new
    @booking = Booking.new
  end

  def create
    @toilet = Toilet.find(params[:toilet_id])
    @booking = Booking.new(booking_params)
    @booking.toilet = @toilet
    @booking.user = current_user
    @booking.price = @booking.toilet.rate * (@booking.check_out - @booking.check_in)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to toilet_path(@toilet)
    end
  end

  def update
    set_booking
    @booking.save!
    redirect_to booking_path(@booking)
  end

  def destroy
    set_booking
    @booking.destroy
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
