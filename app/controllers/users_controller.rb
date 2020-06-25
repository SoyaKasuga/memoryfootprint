class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:destroy,:following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @microposts_all = @user.microposts.all
    @hash = Gmaps4rails.build_markers(@microposts_all) do |micropost, marker|
      marker.lat micropost.latitude
      marker.lng micropost.longitude
      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { micropost: micropost })
    end
    @like_microposts = @user.like_microposts.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user
      flash[:success] = "memoryfootprintへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    testuser = User.find_by(email: "testuser@test.com")
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを消去しました"
    redirect_to users_url
  end
  
  def following
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    @title = "フォロー"
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @title = "フォロワー"
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:introduction,:picture)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
