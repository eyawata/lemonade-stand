class OrdersController < ApplicationController
  def show
    # find order by params id
    # aggregate the total and display end of the list
    @order = Order.find(params[:id])
    @order_subtotal = subtotal
  end

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  private

  def subtotal
    subtotal = 0
    @order.order_products.each do |op|
      product_total = op.product_price_at_sale * op.product_quantity
      subtotal = subtotal + product_total
    end
    return subtotal
  end
end
