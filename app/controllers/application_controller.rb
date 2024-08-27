class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def application
    @orders = Order.all

    if @orders.last&.status == "incomplete"
      @order = @orders.last
    else
      @order = Order.new
      @order.save
    end
  end
end
