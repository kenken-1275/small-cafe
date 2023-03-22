class ReservationsController < ApplicationController

  before_action :authenticate_user!,only:[:new,:back,:confirm,:create,:cancel_confirm,:destroy]
  before_action :reservation_exists?,only: [:new,:back]
  before_action :total_reservations,only: [:new,:back,:confirm,:create]
  before_action :reservation_set,only: [:cancel_confirm,:destroy]


  def index
    if user_signed_in? && Reservation.exists?(user_id:current_user.id)
      @reservation = Reservation.where(user_id:current_user.id)
    end
  end

  def new
    @reservation = Reservation.new
    @store_holidays = StoreHoliday.select(:store_holiday).order(store_holiday:'ASC')
  end

  def back
		@reservation = Reservation.new(session[:reservation])
		session.delete(:reservation)
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
    @reservation = Reservation.new(session[:reservation])
    session.delete(:reservation)
    if @reservation.save
      LinebotController.push(@reservation)
      redirect_to action: :index
    else
      render :new
    end
  end

  def cancel_confirm
  end

  def destroy
    LinebotController.cancel_push(@reservation)
    @reservation.delete
    redirect_to action: :index
  end


  private

  def reservation_params
    params.require(:reservation).permit(:reservation_date,:reservation_time,:people_number,:tel_number).merge(user_id:current_user.id)
  end

  def reservation_exists?
    if Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    end
  end

  def total_reservations
    @reservations = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time).count
    reservations_total = Reservation.select("reservation_date,reservation_time,people_number").group(:reservation_date).group(:reservation_time).sum(:people_number).count
    reservations_total_people_number = reservations_total.values
    i = 0
    @reservations.each do |reservation|
      reservation[:people_number] = reservations_total_people_number[i]
      i+=1
    end
  end

  def reservation_set
    if !Reservation.exists?(user_id:current_user.id)
      redirect_to root_path
    else
    @reservation = Reservation.find_by(user_id:current_user.id)
    end
  end

end
