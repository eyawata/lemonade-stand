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
    @payment_option = params[:order][:payment_option]
    if @payment_option == "paypay"
      redirect_to action: :create_qr_code
      return
      # redirect_to controller: :controller_name, action: :action_name
    end
    raise

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



   def create_qr_code
    require './lib/api_clients/pay_pay'

    builder = PayPay::QrCodeCreateBuilder.new()
    builder.merchantPaymentId
    # addItem(name, category, quantity, product_id, unit_amount)

    @order = Order.last
    @order.order_products.each do |op|
      builder.addItem(op.product.name, op.product.category, op.product_quantity, op.product_id, op.product_price_at_sale)
    end

    client = PayPay::Client.new(ENV['API_KEY'], ENV['API_SECRET'], ENV['MERCHANT_ID'])
    response = client.qr_code_create(builder.finish)
    response_body = JSON.parse(response.body)
    @qr_code_url = response_body.dig("data", "url")
    # redirect_to @qr_code_url, allow_other_host: true
    render "paypay"

    # render json: response.body
    # JSON.parse(response.body).dig("data", "url")
  end

end
