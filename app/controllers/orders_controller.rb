class OrdersController < ApplicationController
  def show
    # find order by params id
    # for each order_product, display it in a list
    # aggregate the total and display end of the list

    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end
end
