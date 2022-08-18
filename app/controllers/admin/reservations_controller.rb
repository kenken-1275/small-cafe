class Admin::ReservationsController < ApplicationController
  before_action :check_admin?

  def index
    @reservations = Reservation.all.order('reservation_date ASC')
  end

  def new
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
		  @reservation = Reservation.new(session[:reservation])
		  session.delete(:reservation)
		  redirect_to action: :new
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

  def show
    @reservation = Reservation.find(params[:id])
    session[:id] = params[:id] 
  end

  def edit
    @announce = Announce.find(params[:id])
  end

  def update
    @announce = Announce.find(params[:id])
    if @announce.update(announce_params)
      redirect_to action: :index
    else
      render :edit
    end
  end

  def cancel_confirm
    @reservation = Reservation.find(session[:id])
  end

  def destroy
    @reservation = Reservation.find(session[:id])
    session.delete(:id)
    if @reservation.destroy
      redirect_to action: :index
    end
  end
  

  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  def reservation_params
    params.require(:reservation).permit(:reservation_date,:reservation_time,:people_number,:tel_number).merge(user_id:current_user.id)
  end

end