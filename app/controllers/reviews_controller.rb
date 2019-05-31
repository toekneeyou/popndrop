class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @booking = Booking.find(params[:booking_id]) if params.key? :booking_id
    @review = Review.new
  end

  def create
    @booking = Booking.find(params[:booking_id]) if params.key? :booking_id
    @review = Review.new(review_params)
    if params.key? :booking_id
      @review.reviewable = @booking
      @review.user_id = @booking.toilet.user_id
    else
      @review.reviewable = User.find(params[:user_id])
      @review.user_id = params[:user_id]
    end
    if
      @review.save
      if params.key? :booking_id
        redirect_to booking_path(@booking)
      else
        redirect_to poopspace_user_path(params[:user_id])
      end
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:reviewable, :content, :rating)
  end

  def set_booking
  end
end
