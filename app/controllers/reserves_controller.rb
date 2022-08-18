class ReservesController < ApplicationController

  before_action :authenticate_user!,only:[:new,:back,:confirm,:create]

  def index
    if user_signed_in? && Reserve.exists?(user_id:current_user.id)
      @reserve = Reserve.where(user_id:current_user.id)
    end
  end

  def new
    if Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    end
    @reservations = Reserve.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time)
    reservations_total = Reserve.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time).sum(:people_number)
    reservations_total_people_number = reservations_total.values
    i = 0
    @reservations.each do |reservation|
      reservation[:people_number] = reservations_total_people_number[i]
      i+=1
    end
    @reserve = Reserve.new
  end

  def back
    if Reserve.exists?(user_id:current_user.id)
      redirect_to root_path
    else
		  @reserve = Reserve.new(session[:reserve])
		  session.delete(:reserve)
		  redirect_to action: :new
    end
	end

  def confirm
    @reserve = Reserve.new(reserve_params)
    session[:reserve] = @reserve
    if @reserve.invalid?
			redirect_to action: :new
		end
  end

  def create
    @reserve = Reserve.new(session[:reserve])
    session.delete(:reserve)
    if @reserve.save
      redirect_to action: :index
    else
      redirect_to action: :new
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
    params.require(:reserve).permit(:reservation_date,:reservation_time,:people_number,:tel_number).merge(user_id:current_user.id)
  end

end
