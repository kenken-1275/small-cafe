class AnnouncesController < ApplicationController

  def show
    @announce = Announce.find(params[:id])
  end

end
