module TestHelper
  
  def log_in_as(user)
    post login_path, params: { session: { email: user.email,
                                        password: user.password } }
  end
  
  def is_logged_in?
    !session[:user_id].nil?
  end
end