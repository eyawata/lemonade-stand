class ProductsController < ApplicationController
  before_action :authenticate_user!

  def show
    @product = Product.find(params[:id])
  end

  def index
    @current_page = 'products'
    @products = current_user.products
    @product = Product.new
    if Order.any?
      @order = Order.last
    else
      @order = Order.create(total_price: 0)
    end
  end

  # def edit
  #   @edit_product = Product.find(params[:id])
  # end

  def update
    @edit_product = Product.find(params[:id])
    if @edit_product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def import
    current_user.my_import(params[:file])
    redirect_to products_path, notice: 'Products imported.'
  end

  def create
    @products = Product.all
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category, :quantity, :photo)
  end
end
