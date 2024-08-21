class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def new
    @products = Product.all
    @orders = Order.all
    @order = Order.new

    redirect_to order_path(order.last) if @orders.last&.status == "incomplete"
  end
end
