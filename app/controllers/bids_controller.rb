class BidsController < ApplicationController

  before_action :check_user_and_admin, only: [:create]

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    bid_params = params.require(:bid).permit(:amount)
    @bid = @auction_lot.bids.build(bid_params)
    @bid.user = current_user
    if @bid.save
      redirect_to @auction_lot, notice: "Lance enviado com sucesso!"
    else
      redirect_to @auction_lot, alert: @bid.errors.full_messages.join(', ')
    end
  end

  private

  def check_user_and_admin
    if !current_user.present?
      return redirect_to new_user_session_path, alert: "Para realizar um lance você precisa estar logado"
    elsif current_user.admin?
      return redirect_to root_path, alert: "Administradores não podem realizar lances"
    end
  end
end