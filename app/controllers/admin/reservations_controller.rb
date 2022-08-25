class Admin::ReservationsController < ApplicationController
  before_action :check_admin?
  before_action :total_reservations,only: [:new,:back,:confirm,:create]
  before_action :reservation_session_set,only: [:back,:create]
  before_action :reservation_set,only: [:cancel_confirm,:destroy]

  def index
    @reservations = Reservation.all.order('reservation_date').order('reservation_time')
  end

  def new
    @reservation = Reservation.new
  end

  def back
		render :new
	end

  def confirm
    @reservation = Reservation.new(reservation_params)
    session[:reservation] = @reservation
    if @reservation.invalid?
			render :new
		end
  end

  def create
    if @reservation.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    session[:id] = params[:id] 
  end

  def cancel_confirm
  end

  def destroy
    session.delete(:id)
    @reservation.destroy
    redirect_to action: :index
  end
  

  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  def reservation_params
    params.require(:reservation).permit(:reservation_date,:reservation_time,:people_number,:tel_number,:name).merge(user_id:current_user.id)
  end

  def total_reservations
    @reservations = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time)
    reservations_total = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time).sum(:people_number)
    reservations_total_people_number = reservations_total.values
    i = 0
    @reservations.each do |reservation|
      reservation[:people_number] = reservations_total_people_number[i]
      i+=1
    end
  end

  def reservation_session_set
    @reservation = Reservation.new(session[:reservation])
    session.delete(:reservation)
  end

  def reservation_set
    @reservation = Reservation.find(session[:id])
  end

end