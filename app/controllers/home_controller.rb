class HomeController < ApplicationController

  def index
    @auction_lots = AuctionLot.all
    @products = Product.all
  end
end