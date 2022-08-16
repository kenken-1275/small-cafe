class Admin::ReservesController < ApplicationController
  before_action :check_admin?

  def index
    @reservations = Reserve.all.order('reservation_date ASC')
  end

  def new
    @announce = Announce.new
  end

  def create
    @announce = Announce.new(announce_params)
    if @announce.save
      redirect_to action: :index
    else
      render :new
    end
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

  def destroy
    @announce = Announce.find(params[:id])
    if @announce.destroy
      redirect_to action: :index
    end
  end
  

  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  def announce_params
    params.require(:announce).permit(:date,:title,:content)
  end

end