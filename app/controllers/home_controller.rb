class HomeController < ApplicationController

  def index
    @auction_lots = AuctionLot.draft
    @auction_lots_actives = AuctionLot.active
    @products = Product.all
  end
end