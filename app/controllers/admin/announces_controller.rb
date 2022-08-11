class Admin::AnnouncesController < ApplicationController
  before_action :check_admin?

  def index
    @announces = Announce.all
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
