class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to @product, notice: "Product #{@product.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :category, :quantity)
  end
end
