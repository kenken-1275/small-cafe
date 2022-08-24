class Admin::PastReservationsController < ApplicationController
  before_action :check_admin?

  def index
    @past_reservations = PastReservation.all.order('reservation_date').order('reservation_time')
  end

  def show
    @past_reservation = PastReservation.find(params[:id])
  end
  
  

  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

end