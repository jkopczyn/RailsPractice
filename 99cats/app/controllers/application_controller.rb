#require 'byebug'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

  def current_user
    if session[:session_token].nil?
      @current_user = nil
      return nil
    end
    @current_user = User.find_by_session_token([session[:session_token]])
  end

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def redirect_logged_in
    return if current_user.nil?
    redirect_to cats_url
  end
 
  def cats_owner(object)
    if object.class == Cat
      object.owner
    elsif object.class == CatRentalRequest
      object.cat.owner
    else
      raise "That has no cat to find the owner of"
    end
  end

  helper_method :cats_owner 
  helper_method :current_user
  helper_method :login!
end
