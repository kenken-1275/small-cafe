class Api::ResavationTimesController < ApplicationController

  def index
    resavation_dates = Reserve.where(resavation_date:params[:resavation_date])


    base_resavation_dates = Reserve.time_option

    # ['11:00','12:00','13:00','14:00','15:00','16:00']

    base_resavation_dates_and_people_number = base_resavation_dates.each_with_object({}) { |date, hash| hash[date] = 0 }

    # {"11:00"=>0, "12:00"=>0, "13:00"=>0, "14:00"=>0, "15:00"=>0, "16:00"=>0}


    resavation_dates.each do |resavation_date|
      base_resavation_dates_and_people_number[resavation_date.perse_resavation_time] = base_resavation_dates_and_people_number[resavation_date.perse_resavation_time] + resavation_date.people_number
    end

    response_hash = base_resavation_dates_and_people_number.each_with_object({}) do |item, hash|  
      hash[item.first] = (item.second < 3) 
    end

    render json:{ response_hash: response_hash }
  end

end
