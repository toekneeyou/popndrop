class ToiletsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new, :index]
  # before_action :set_toilet, only: [:index, :show, :new, :create]

  def index
    @toilets = Toilet.all
  end

  def show
    @toilet = Toilet.find(params[:id])
  end

  def new
    @toilet = Toilet.new
    @toilet.user = current_user
  end

  def edit
    set_toilet
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
    set_toilet
    @toilet.update(toilet_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    set_toilet
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
end
