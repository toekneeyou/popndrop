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
    @guest = @booking.user
    if @guest == current_user
      @review.reviewable = @booking
    else
      @review.reviewable = @guest
    end
    @review.user = current_user
    if
      @review.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:reviewable, :content, :rating)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
