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

  def create
    @product = Product.find(params[:product_id])
    @products = current_user.products
    @order = Order.find(params[:order_id])
    @order_product = @order.order_products.find_by(product: @product)
    if @order_product
      @order_product.update(product_quantity: params[:increment].present? ? @order_product.product_quantity + 1 : @order_product.product_quantity - 1)
    else
      @order_product = OrderProduct.create(order: @order, product: @product, product_quantity: 1, product_price_at_sale: @product.price)
    end

     respond_to do |format|
      format.json
    end
  end
end
