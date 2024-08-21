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

  def update
    @order = Order.find(params[:id])

    # update_inventory is an instance method in order.rb
    @order.update_inventory

    # mark order as complete and order's total price
    @order.update(status: "completed", total_price: @order.subtotal)

    @last_order = Order.new(total_price: 0)
    @last_order.save
    redirect_to edit_order_path(@last_order)
    # flash order "order confirmed"
  end
end
