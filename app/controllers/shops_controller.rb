class ShopsController < ApplicationController

  def index
    @announces = Announce.all
  end

  def show
  end
  
end
