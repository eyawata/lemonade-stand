class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])

    # subtotal is an instance method in order.rb
    @order_subtotal = @order.subtotal
  end

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

end
