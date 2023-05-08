class ProductItemsController < ApplicationController

  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @product_item = ProductItem.new
    @products = Product.all
  end

  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    product_item_params = params.require(:product_item).permit(:product_id)

    @product_item = @auction_lot.product_items.build(product_item_params)

    if @auction_lot.save
      redirect_to @auction_lot, notice: 'Item adicionado com sucesso.'
    else
      render :new
    end
  end

  def destroy
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @product_item = @auction_lot.product_items.find(params[:id])
    @product_item.destroy
    redirect_to @auction_lot, notice: 'Item removido com sucesso.'
  end
end