class Api::ReservationPeopleNumbersController < ApplicationController

  def index
    reservation_dates = Reservation.where(reservation_date:params[:reservation_date])


    base_reservation_dates = Reservation.time_option

    # ['11:00','12:00','13:00','14:00','15:00','16:00']

    base_reservation_dates_and_people_number = base_reservation_dates.each_with_object({}) { |date, hash| hash[date] = 0 }

    # {"11:00"=>0, "12:00"=>0, "13:00"=>0, "14:00"=>0, "15:00"=>0, "16:00"=>0}


    reservation_dates.each do |reservation_date|
      base_reservation_dates_and_people_number[reservation_date.perse_reservation_time] = base_reservation_dates_and_people_number[reservation_date.perse_reservation_time] + reservation_date.people_number
    end

    response_hash = base_reservation_dates_and_people_number.each_with_object({}) do |item, hash|  
      hash[item.first] = (item.second) 
    end

    render json:{ response_hash: response_hash }
  end

end