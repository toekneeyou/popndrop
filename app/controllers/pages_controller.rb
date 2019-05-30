class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    @toilet = Toilet.new
    @toilets = Toilet.all

    request.location #grab your current location
    @userLocation = request.location #gets the ip of the user
    # @searchResults = Geocoder.search(search_locations)
    # @locations = @searchResults.near(@userLocation, 50, :order => :distance)

  end
end
