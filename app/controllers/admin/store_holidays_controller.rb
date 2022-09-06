class Admin::StoreHolidaysController < ApplicationController
  before_action :check_admin?
  before_action :total_reservations,only: [:index,:new]

  def index
    @store_holidays = StoreHoliday.all
  end

  def new
    @store_holiday = StoreHoliday.new
  end

  def create
    store_holiday = StoreHoliday.create(store_holiday_params)
    redirect_to admin_store_holidays_path
  end


  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
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

  def store_holiday_params
    params.require(:store_holiday).permit(:store_holiday)
  end

end