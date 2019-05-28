class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @review.booking_id = Booking.find(params[:booking_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      @review = Review.new(review_params)
      redirect_to reviews_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
