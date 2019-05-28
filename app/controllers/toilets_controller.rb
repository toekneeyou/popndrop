class ToiletsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new, :index]
  before_action :set_toilet, only: [:show, :new, :create, :edit, :update, :destroy]

  def index
    @toilets = Toilet.all
  end

  def show
    @booking = Booking.new
    # @average_rating = average_rating(@toilet)
    # hiding for now since we don't have reviews yet
  end

  def new
    @toilet = Toilet.new
    @toilet.user = current_user
  end

  def edit
  end

  def create
    @toilet = Toilet.new(toilet_params)
    @toilet.user = current_user
    if @toilet.save
      redirect_to toilet_path(@toilet)
    else
      @toilet = Toilet.new(toilet_params)
      redirect_to toilets_path
    end
  end

  def update
    @toilet.update(toilet_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    @toilet.destroy
    redirect_to root_path
  end

  private

  def toilet_params
    params.require(:toilet).permit(:name, :address, :rate, :description)
  end

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def average_rating(toilet)
    total = 0
    toilet.reviews.each do |review|
      total += review.rating
    end
    average = (total / toilet.reviews.length)
    return average
  end
end
