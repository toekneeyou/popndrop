class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @toilet = Toilet.new
    @toilets = Toilet.all
  end
end
