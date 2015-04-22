class CatRentalRequestsController < ApplicationController
  before_action :check_cats_owner, only: [:approve, :deny]

  def new
    @cat_rental = CatRentalRequest.new
    render :new
  end

  def create
    params[:user_id] = current_user.id
    @cat_rental = CatRentalRequest.new(rental_params)
    if @cat_rental.save
      redirect_to cat_url(@cat_rental.cat_id)
    else
      render :new
    end
  end

  def approve
    @cat_rental = CatRentalRequest.find(params[:id])
    @cat_rental.approve!
    redirect_to :back
  end

  def deny
    @cat_rental = CatRentalRequest.find(params[:id])
    @cat_rental.deny!
    redirect_to :back
  end

  private
  def rental_params
    params.require(:cat_rental_request)
          .permit(:start_date, :end_date, :cat_id, :user_id)
  end

  def check_cats_owner
    unless cats_owner(self) == current_user
      redirect_to cats_url
    end
  end
end
