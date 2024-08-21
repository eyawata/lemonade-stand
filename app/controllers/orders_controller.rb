class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @products = Product.all

    # subtotal is an instance method in order.rb
    @order_subtotal = @order.subtotal
  end

  def index
    @orders = Order.all
  end

  def edit
    @products = Product.all
    @orders = Order.all

    if @orders.last&.status == "incomplete"
      @order = @orders.last
    else
      @order = Order.new
      @order.save
    end

    # redirect_to order_path(@orders.last) if @orders.last&.status == "incomplete"
  end
end
