class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.where(user_id: current_user.id)
    @review = Review.new
  end

  def show
    @toilet = @booking.toilet
    @host = @toilet.user
    @guest = @booking.user
    @review = Review.new
    @markers = [{
      lat: @toilet.latitude,
      lng: @toilet.longitude,
      infoWindow: render_to_string(partial: "infowindow", locals: { toilet: @toilet }),
      image_url: helpers.asset_url('dancing-paper.gif')
    }]
  end

  def new
    @booking = Booking.new
  end

  def create
    @toilet = Toilet.find(params[:toilet_id])
    @booking = Booking.new(booking_params)
    @booking.toilet = @toilet
    @booking.user = current_user
    @booking.price = @booking.toilet.rate * ((@booking.check_out - @booking.check_in)/60)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to toilet_path(@toilet)
    end
  end

  def edit
  end

  def update
    @booking.save!
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking.destroy
    redirect_to poopspace_user_path(current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
