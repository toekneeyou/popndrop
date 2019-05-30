class ReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create]
  def index
    @reviews = Review.all
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.reviewable = @booking
    @review.user = current_user
    @review.save
    redirect_to booking_path(@booking)
  end

  private

  def review_params
    params.require(:review).permit(:reviewable, :content, :rating)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
