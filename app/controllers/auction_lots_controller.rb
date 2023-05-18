class AuctionLotsController < ApplicationController

  before_action :check_admin, only: [:edit, :update, :new, :create, :index]

  def index
    @auction_lots = AuctionLot.draft
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
      flash.now[:alert] = "Falha ao criar o lote de leilão"
      render "new"
    end
  end

  def edit
    @products = Product.all
    @auction_lot = AuctionLot.find(params[:id])
  end

  def update
    @auction_lot = AuctionLot.find(params[:id])
    auction_lot_params = params.require(:auction_lot).permit(:start_date, :end_date, :minimum_value,
                                        :diff_value)

    if @auction_lot.update(auction_lot_params)
      redirect_to auction_lot_path(params[:id]), notice: "Lote de leilão atualizado com sucesso."
    else
      @products = Product.all
      flash[:alert] = "Não foi possivel atualizar o lote."
      render "edit"
    end
  end

  def active
    @auction_lot = AuctionLot.find(params[:id])
    if @auction_lot.admin_record == current_user.email
      redirect_to @auction_lot, alert: "Voce não pode aprovar esse lote"
    elsif @auction_lot.product_items.any?
      @auction_lot.active!
      @auction_lot.admin_approve = current_user.email
      @auction_lot.save
      redirect_to @auction_lot
    else
      redirect_to @auction_lot, alert: "O lote não pode ser aprovado sem ter ao menos um produto vinculados."
    end
  end

  def results
    overdue_lot_query
  end

  def closed
    @auction_lot = AuctionLot.find(params[:id])
    @auction_lot.closed!
    redirect_to results_auction_lots_path, notice: "Lote de leilão finalizado com sucesso!"
  end

  def cancel
    @auction_lot = AuctionLot.find(params[:id])
    
    @auction_lot.product_items.each do |prd_itm|
      product = Product.find(prd_itm.product_id)
      product.active!
    end
    
    if @auction_lot.canceled!
      redirect_to results_auction_lots_path, notice: "Lote de leilão cancelado com sucesso!"
    end
  end

  def customer_results
    if !current_user.present? 
      redirect_to new_user_session_path
    else
    current_user_id = current_user.id
    @auction_lots = AuctionLot.joins(:bids).where("auction_lots.end_date < ? AND auction_lots.status = 5 AND bids.user_id = ?", Date.today, current_user_id)
    end
  end

  def search
    @key = params["query"]
    @auction_lots = AuctionLot.joins(:products).where("products.name LIKE ? OR auction_lots.code LIKE ? ", "%#{@key}%", "%#{@key}%")
  end

  private

  def check_admin
    unless current_user.present? && current_user.admin?
      flash[:alert] = "Apenas usuarios admin tem acesso a essa ação"
      return redirect_to root_path
    end
  end

  def overdue_lot_query
    @auction_lots = AuctionLot.where('end_date <= ? AND status = ?', Date.today, 1)
  end
end