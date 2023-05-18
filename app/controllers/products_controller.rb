class ProductsController < ApplicationController

  before_action :check_admin, only: [:new, :create, :index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit(:name, :description, :photo, :weight,
                                                     :width, :height, :depth, :photo, 
                                                     :category)
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Produto cadastrado com sucesso."
    else
      flash.now[:alert] = "Produto não cadastado."
      render 'new'
    end                                          
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    product_params = params.require(:product).permit(:name, :description, :photo, :weight,
                                                     :width, :height, :depth, :photo, 
                                                     :category)
    if @product.update(product_params)
      redirect_to @product, notice: "Produto atualizado com sucesso."
    else
      flash[:alert] = "Falha ao atualizar o produto."
      render "edit"
    end
  end

  private

  def check_admin
    unless current_user.present? && current_user.admin?
      flash[:alert] = "Apenas usuarios admin podem criar um produto"
      redirect_to root_path
    end
  end
end