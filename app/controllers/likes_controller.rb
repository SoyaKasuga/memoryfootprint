class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    return false if @micropost.like?(current_user)

    @micropost.like(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    return false unless @micropost.like?(current_user)

    @micropost.unlike(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
