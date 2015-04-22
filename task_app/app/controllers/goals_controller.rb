class GoalsController < ApplicationController
  before_action :ensure_viewer_allowed, only: :show
  before_action :ensure_owner, only: [ :edit, :update, :destroy]

  def new
    render :new
  end

  def create
    user_id = params[:user_id]
    @goal = Goal.new(goal_params)
    @goal.user_id = user_id
    if @goal.save
      redirect_to user_goal_url(@goal.user,@goal)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    @user = @goal.user
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    @user = @goal.user
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_goal_url(@goal.user,@goal)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @user = @goal.user
    @goal.destroy
    redirect_to user_url(@user)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :content)
  end

  def ensure_viewer_allowed
    goal = Goal.find(params[:id])

    if goal.private && current_user.id != params[:user_id].to_i
      redirect_to user_url(params[:user_id])
    end
  end

  def ensure_owner
    goal = Goal.find(params[:id])

    if current_user.id != params[:user_id].to_i
      redirect_to user_url(params[:user_id])
    end
  end
end
