class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @current_page = 'home'
    @product = Product.new
    if Order.any?
      @order = Order.last
    else
      @order = Order.create(total_price: 0)
    end
  end
end
