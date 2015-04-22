class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    credentials = [params[:user][:username], params[:user][:password]]
    @user = User.find_by_credentials(*credentials)
    if @user.nil?
      render :new
    else
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
