class Admin::ReservesController < ApplicationController
  before_action :check_admin?

  def index
    @reservations = Reserve.all.order('reservation_date ASC')
  end

  def new
    @reservation = Reserve.new
  end

  def back
		  @reservation = Reserve.new(session[:reserve])
		  session.delete(:reserve)
		  redirect_to action: :new
	end

  def confirm
    @reservation = Reserve.new(reservation_params)
    session[:reservation] = @reservation
    if @reservation.invalid?
			redirect_to action: :new
		end
  end

  def create
    @reservation = Reserve.new(session[:reservation])
    session.delete(:reservation)
    if @reservation.save
      redirect_to action: :index
    else
      redirect_to action: :new
    end
  end

  def show
    @reservation = Reserve.find(params[:id])
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
    @reservation = Reserve.find(session[:id])
  end

  def destroy
    @reservation = Reserve.find(session[:id])
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
    params.require(:reserve).permit(:reservation_date,:reservation_time,:people_number,:tel_number).merge(user_id:current_user.id)
  end

end