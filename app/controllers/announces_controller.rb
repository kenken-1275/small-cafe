class AnnouncesController < ApplicationController
  before_acton :check_admin?

  def index
  end

  def new
  end

  def create
  end
  

  private

  def check_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

end
