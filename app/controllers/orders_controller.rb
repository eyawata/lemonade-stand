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

  def update
    @order = Order.find(params[:id])

    # update_inventory is an instance method in order.rb
    @order.update_inventory

    # mark order as complete and order's total price
    @order.update(status: "completed", total_price: @order.subtotal)

    # redirect to orders/new
    redirect_to new_order_path

    # flash order "order confirmed"
  end
end
