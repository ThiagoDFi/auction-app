class AuctionLotsController < ApplicationController

  def index
    @auction_lots = AuctionLot.all
  end

  def show
    @auction_lot = AuctionLot.find(params[:id])
    @bid = Bid.new
    @amount = @auction_lot.bids.last
  end

  def new
    @auction_lot = AuctionLot.new
    @auction_lot.product_items.build
    @products = Product.all
    @product = Product.new
    unless current_user.admin?
      flash[:notice] = "Apenas usuarios admin podem criar um produto"
      redirect_to root_path
    end
  end

  def create
    auction_lot_params = params.require(:auction_lot).permit(:end_date, :minimum_value, :diff_value,
                                                             :code, :start_date)
    @auction_lot = AuctionLot.new(auction_lot_params)
    @auction_lot.admin_record = current_user.email
    if @auction_lot.save
      redirect_to @auction_lot, notice: "Cadastro do lote de leilão efetuado com sucesso."
    else
      @products = Product.all
      flash.now[:notice] = "Falha ao criar o lote de leilão"
      render "new"
    end
  end

  def edit
    @products = Product.all
    @auction_lot = AuctionLot.find(params[:id])
  end

  def update
    @auction_lot = AuctionLot.find(params[:id])
    auction_lot_params = params.require(:auction_lot).permit(:end_date, :minimum_value,
                                        :diff_value)
    if @auction_lot = AuctionLot.update(auction_lot_params)
      redirect_to auction_lot_path(params[:id]), notice: "Lote de leilão atualizado com sucesso."
    else
      @products = Product.all
      flash[:notice] = "Não foi possivel atualizar o pedido."
      render "edit"
    end
  end

  def active
    @auction_lot = AuctionLot.find(params[:id])
    if @auction_lot.admin_record == current_user.email
      redirect_to @auction_lot, notice: "Voce não pode aprovar esse lote"
    else
      @auction_lot.active!
      @auction_lot.admin_approve = current_user.email
      @auction_lot.save
      redirect_to @auction_lot
    end
  end
end