class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントしました'
    else
      flash[:danger] = 'コメントできません'
    end
    redirect_to request.referer || current_user
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    redirect_to request.referer || current_user
  end

  private

  def comment_params
    params.require(:comment).permit(:micropost_id, :content)
  end
end
