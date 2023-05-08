class ProductItemsController < ApplicationController

  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @product_item = ProductItem.new
    @products = Product.all
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    product_item_params = params.require(:product_item).permit(:product_id)

    @product_item = ProductItem.new(product_item_params)
    @product_item.auction_lot = @auction_lot
    if @product_item.save
      redirect_to @auction_lot, notice: 'Item adicionado com sucesso.'
    end
  end
end