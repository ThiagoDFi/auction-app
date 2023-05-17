class FavoritesController < ApplicationController

  def index
    if !current_user.present? 
      redirect_to new_user_session_path
    else
    @favorites = current_user.favorites.includes(auction_lot: :products)
    end
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    user = current_user 
    @favorite =  Favorite.new(user: user, auction_lot: @auction_lot)
    if @favorite.save
      redirect_to favorites_path
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to @favorite, notice: "O lote foi removido dos favoritos."
  end
end