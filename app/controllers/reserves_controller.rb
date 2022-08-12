class ReservesController < ApplicationController

  def index
  end

  def new
    @reserve = Reserve.new
  end

  def create
    @reserve = Reserve.new(reserve_params)
    if @reserve.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private
  def reserve_params
    params.require(:reserve).permit(:date,:time_id,:people_number_id,:tel_number).merge(user_id:current_user.id)
  end

end
