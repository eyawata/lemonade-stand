class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
    @product = Product.new
    # @edit_product = Product.find(params[:id])
  end

  # def edit
  #   @edit_product = Product.find(params[:id])
  # end

  def update
    @edit_product = Product.find(params[:id])
    if @edit_product.update(product_params)
      redirect_to products_path 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def new
  #   @product = Product.new
  # end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path
      # redirect_to @product, notice: "Product #{@product.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category, :quantity, :photo)
  end
end
