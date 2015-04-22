class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :is_logged_in?

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
    self.current_user = user
  end

  def logout!
    self.current_user.reset_session_token!
    session[:session_token] = nil
  end

  def is_logged_in?
    !!self.current_user
  end
end
