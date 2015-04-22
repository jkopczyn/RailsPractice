class SessionsController < ApplicationController
  before_action :redirect_logged_in, only: :new

  def new
    render :new
  end

  def create
    credentials = params[:user][:user_name], params[:user][:password]
    @user = User.find_by_credentials(*credentials)
    @user.reset_session_token!
    login!(@user)
    redirect_to cats_url
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
