class Admin::StoreHolidaysController < ApplicationController
  before_action :check_admin?
  before_action :total_reservations,only: [:index,:new,:create]

  def index
    @store_holidays = StoreHoliday.all.order(store_holiday:'ASC')
    @days = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def new
    @store_holiday = StoreHoliday.new
    @store_holidays = StoreHoliday.select(:store_holiday).order(store_holiday:'ASC')
    @result = @store_holidays.each_with_object([]) do |(k,v),memo|
      memo << k[:store_holiday].to_s
    end
    p @result
  end

  def create
    @store_holiday = StoreHoliday.new(store_holiday_params)
    if @store_holiday.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @store_holiday = StoreHoliday.find(params[:id])
    @days = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def destroy
    @store_holiday = StoreHoliday.find(params[:id])
    @store_holiday.delete
    redirect_to action: :index
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