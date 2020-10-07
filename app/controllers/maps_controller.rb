class MapsController < ApplicationController
  def index
    @microposts = Micropost.all
    @hash = Gmaps4rails.build_markers(@microposts) do |micropost, marker|
      marker.lat micropost.latitude
      marker.lng micropost.longitude
      marker.picture({
        :url => "https://memoryfootbucket.s3-ap-northeast-1.amazonaws.com/uploads/direct-access/picture/48pxfootprint.png",
        :width   => 48,
        :height  => 48
      })
      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { micropost: micropost })
    end
  end
end
