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
    @product = Product.new
    if current_user.role != 'admin'
      flash[:notice] = "Apenas usuarios admin podem criar um produto"
      redirect_to root_path
    end
  end

  def create
    auction_lot_params = params.require(:auction_lot).permit(:end_date, :minimum_value, :diff_value,
                                                             :code, product_id: [])
    @auction_lot = AuctionLot.new(auction_lot_params)
    # binding.pry
    @auction_lot.admin_record = current_user.email
    @auction_lot.start_date = Date.today
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
    auction_lot_params = params.require(:auction_lot).permit(:product_id, :end_date, :minimum_value,
                                        :diff_value)
    if @auction_lot = AuctionLot.update(auction_lot_params)
      redirect_to auction_lot_path(params[:id]), notice: "Lote de leilão atualizado com sucesso."
    else
      @products = Product.all
      flash[:notice] = "Não foi possivel atualizar o pedido."
      render "edit"
    end
  end
end