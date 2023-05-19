class HomeController < ApplicationController

  def index
    @auction_lots_actives = AuctionLot.active
  end
end