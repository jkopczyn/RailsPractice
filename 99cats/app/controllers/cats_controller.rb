class CatsController < ApplicationController
  before_action :check_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @rental_requests = CatRentalRequest.where(cat_id: @cat.id).order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def create
    params[:user_id] = current_user.id
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :user_id, :description)
  end

  def check_owner
    unless cats_owner(self) == current_user
      redirect_to cats_url
    end
  end
end
