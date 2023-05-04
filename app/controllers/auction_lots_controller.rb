class AuctionLotsController < ApplicationController

  def index
    @auction_lots = AuctionLot.all
  end

  def show
    @auction_lot = AuctionLot.find(params[:id])
  end

  def new
    @auction_lot = AuctionLot.new
    @products = Product.all
  end

  def create
    auction_lot_params = params.require(:auction_lot).permit(:end_date, :minimum_value, :diff_value,
                                                             :code, :product_id)
    @auction_lot = AuctionLot.new(auction_lot_params)
    @auction_lot.admin_record = current_user.email
    @auction_lot.start_date = Date.today
    if @auction_lot.save
      redirect_to @auction_lot, notice: "Cadastro do lote de leilão efetuado com sucesso."
    else
      @products = Product.all
      flash[:notice] = "Falha ao criar o lote de leilão"
      render "new"
    end
  end
end