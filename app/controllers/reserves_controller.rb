class ReservesController < ApplicationController

  before_action :authenticate_user!,only:[:new,:back,:confirm,:create,:cancel_confirm,:destroy]

  def index
    if user_signed_in? && Reserve.exists?(user_id:current_user.id)
      @reserve = Reserve.find_by(user_id:current_user.id)
    end
  end

  def new
    if Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    end
    @reserve = Reserve.new
  end

  def back
    if Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    else
		  @reserve = Reserve.new(session[:reserve])
		  session.delete(:reserve)
		  render :new
    end
	end

  def confirm
    @reserve = Reserve.new(reserve_params)
    session[:reserve] = @reserve
    if @reserve.invalid?
			render :new
		end
  end

  def create
    @reserve = Reserve.new(session[:reserve])
    session.delete(:reserve)
    if @reserve.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def cancel_confirm
    @reserve = Reserve.find_by(user_id:current_user.id)
    if !Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    end
  end

  def destroy
    @reserve = Reserve.find_by(user_id:current_user.id)
    if !Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    else @reserve.delete
      redirect_to action: :index
    end
  end

  private
  def reserve_params
    params.require(:reserve).permit(:resavation_date,:resavation_time_id,:people_number_id,:tel_number).merge(user_id:current_user.id)
  end

end
