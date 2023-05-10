class BidsController < ApplicationController

  def new
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    bid_params = params.require(:bid).permit(:amount)
    @bid = @auction_lot.bids.build(bid_params)
    @bid.user = current_user
    if @bid.save
      redirect_to @auction_lot, notice: "Lance enviado com sucesso!"
    else
      redirect_to @auction_lot, notice: @bid.errors.full_messages.join(', ')
    end
  end
end