class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました'
      redirect_to current_user
    else
      render 'microposts/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to current_user
  end

  def index
    @microposts = Micropost.all.paginate(page: params[:page])
    @comment = current_user.comments.build if current_user.present?
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comment = current_user.comments.build if current_user.present?
  end

  def new
    @user = current_user
    @micropost = current_user.microposts.build
  end

  def rank
    @like_ranks = Micropost.unscoped.find(Like.group(:micropost_id)
                           .order('count(micropost_id) desc').limit(5).pluck(:micropost_id))
    @month_data = Like.where(updated_at: Time.current.all_month)
    @month_ranks = Micropost.unscoped.find(@month_data.group(:micropost_id)
                            .order('count(micropost_id) desc').limit(5).pluck(:micropost_id))
    @hash = Gmaps4rails.build_markers(@like_ranks) do |micropost, marker|
      marker.lat micropost.latitude
      marker.lng micropost.longitude
      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { micropost: micropost })
    end
    @comment = current_user.comments.build if current_user.present?
  end

  def search
    @microposts = Micropost.search(params[:search]).paginate(page: params[:page])
    @keyword = params[:search]
    @microposts_count = Micropost.search(params[:search]).length
    render 'index'
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture, :address, :longitude, :latitude, :due_on)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
