class MapsController < ApplicationController
  def index
    @microposts = Micropost.all
    @hash = Gmaps4rails.build_markers(@microposts) do |micropost, marker|
      marker.lat micropost.latitude
      marker.lng micropost.longitude
      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { micropost: micropost })
    end
  end
end
