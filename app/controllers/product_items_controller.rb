class ProductItemsController < ApplicationController

  before_action :check_admin, only: [:new, :create, :destroy]

  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @product_item = ProductItem.new
    @products = Product.active
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    product_item_params = params.require(:product_item).permit(:product_id)

    @product_item = @auction_lot.product_items.build(product_item_params)

    if @auction_lot.save
      @product_item.product.inactive!
      redirect_to @auction_lot, notice: 'Item adicionado com sucesso.'
    else
      render :new
    end
  end

  def destroy
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @product_item = @auction_lot.product_items.find(params[:id])
  
    if @auction_lot.active?
      redirect_to @auction_lot, alert: 'Não é possível remover o item de um leilão ativo.'
    else
      @product_item.destroy
      @product_item.product.active!
      redirect_to @auction_lot, notice: 'Item removido com sucesso.'
    end
  end

  def check_admin
    unless current_user.present? && current_user.admin?
      flash[:alert] = "Apenas usuarios admin tem acesso a essa ação"
      return redirect_to root_path
    end
  end
end