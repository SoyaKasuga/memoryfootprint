class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました"
      redirect_to current_user
    else
      render 'microposts/new'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to current_user
  end
  
  def index
    @microposts = Micropost.all.paginate(page: params[:page])
  end
  
  def new
    @user = current_user
    @micropost = current_user.microposts.build
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content,:picture,:address,:longitude,:latitude,:due_on)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
    
  
end
