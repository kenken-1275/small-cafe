class ShopsController < ApplicationController

  def index
    @announces = Announce.all.order('created_at DESC')
  end

  def introduction
  end

  def menu
  end
  
end
