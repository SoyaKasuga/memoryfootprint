class TestsessionsController < ApplicationController
  def create
    if current_user == User.find_by(email: "testuser@test.com")
      flash[:danger] = "すでにテストユーザーとしてログインしています"
      redirect_to current_user
    elsif current_user != nil
      flash[:danger] = "テストユーザーとしてログインするために一度ログアウトしてください"
      redirect_to current_user
    else
      user = User.find_by(email: "testuser@test.com")
      log_in user
      flash[:success] = "テストユーザーとしてログインしました"
      redirect_to user
    end
  end
end
