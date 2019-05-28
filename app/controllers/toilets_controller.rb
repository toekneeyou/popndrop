class ToiletsController < ApplicationController
    # before_action :set_toilet, only: [:index, :show, :new, :create]

  def index
    @toilets = Toilet.all
  end

  def show
    @toilet = Toilet.find(params[:id])
  end

  def new
    @toilet = Toilet.new
    @toilet.user_id = User.find(params[:id])
  end

  def create
    @toilet = Toilet.new(toilet_params)
    if @toilet.save
      redirect_to toilet_path(@toilet)
    else
      @toilet = Toilet.new(toilet_params)
      redirect_to toilets_path
    end
  end

  private

  def toilet_params
    params.require(:toilet).permit(:name, :address, :rate, :description)
  end
end
