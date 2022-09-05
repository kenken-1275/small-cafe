namespace :past_reservation_task do
  desc '過去の予約をアーカイブする'
  task past_reservation_move: :environment do
    if Reservation.exists?(reservation_date:Date.today-1.day)
      @past_reservation = Reservation.where(reservation_date:Date.today-1.day)
      @past_reservation.each do |past_reservation|
        attributes = past_reservation.attributes 
        PastReservation.create(attributes)
        Reservation.delete(past_reservation)
      end
    end
  end
end
