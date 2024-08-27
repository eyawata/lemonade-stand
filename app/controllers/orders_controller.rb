class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
    @products = Product.all

    # subtotal is an instance method in order.rb
    @order_subtotal = @order.subtotal
    @discount_options = [['5%', 5], ['10%', 10], ['20%', 20]]

    # Payment options
    @payment_options = [['Cash', 'cash'], ['PayPay', 'paypay']]
  end

  def index
    @orders = Order.all
    @order = Order.where(status: "incomplete").last
  end

  def edit
    @products = current_user.products
    @orders = Order.all
    @order = Order.find(params[:id])

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

    # mark order as complete and order's total price (inclusive of discount selected)
    @discount = params[:order][:order_discount].to_i.fdiv(100) * @order.subtotal
    @order_total_price = @order.subtotal - @discount
    @order.update(status: "completed", total_price: @order_total_price, order_discount: @discount)

    # create a new empty order
    @last_order = Order.new(total_price: 0)
    @last_order.save

    # flash message in redirected page
    flash[:notice] = "Checked out successfully!"

    # redirect to new order
    redirect_to edit_order_path(@last_order)
  end
end
