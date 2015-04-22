class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:session][:username],
      params[:session][:password]
    )
    if @user
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:error] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_api_session_url
  end

  def new
    @user = User.new
    render :new
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
