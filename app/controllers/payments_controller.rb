class PaymentsController < ApplicationController
  def create_qr_code
    require './lib/api_clients/pay_pay'

    builder = PayPay::QrCodeCreateBuilder.new
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
    redirect_to @qr_code_url, allow_other_host: true

    # render json: response.body
    # JSON.parse(response.body).dig("data", "url")
  end
end
