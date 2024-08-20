class OrderProductsController < ApplicationController
  def show
    @order_product = OrderProduct.find(params[:id])
  end

  def index
    @order_products = OrderProduct.all
  end

  def edit
    # In construction
  end
end
