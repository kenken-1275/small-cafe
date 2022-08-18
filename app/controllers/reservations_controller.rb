class ReservationsController < ApplicationController

  before_action :authenticate_user!,only:[:new,:back,:confirm,:create]

  def index
    if user_signed_in? && Reservation.exists?(user_id:current_user.id)
      @reservation = Reservation.where(user_id:current_user.id)
    end
  end

  def new
    if Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    end
    @reservations = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time)
    reservations_total = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time).sum(:people_number)
    reservations_total_people_number = reservations_total.values
    i = 0
    @reservations.each do |reservation|
      reservation[:people_number] = reservations_total_people_number[i]
      i+=1
    end
    @reservation = Reservation.new
  end

  def back
    if Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    else
		  @reservation = Reservation.new(session[:reservation])
		  session.delete(:reservation)
		  redirect_to action: :new
    end
	end

  def confirm
    @reservation = Reservation.new(reservation_params)
    session[:reservation] = @reservation
    if @reservation.invalid?
			redirect_to action: :new
		end
  end

  def create
    @reservation = Reservation.new(session[:reservation])
    session.delete(:reservation)
    if @reservation.save
      redirect_to action: :index
    else
      redirect_to action: :new
    end
  end

  def cancel_confirm
    @reservation = Reservation.find_by(user_id:current_user.id)
    if !Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    end
  end

  def destroy
    @reservation = Reservation.find_by(user_id:current_user.id)
    if !Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    else @reservation.delete
      redirect_to action: :index
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:reservation_date,:reservation_time,:people_number,:tel_number).merge(user_id:current_user.id)
  end

end