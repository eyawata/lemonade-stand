class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    if @event.nil?
      @orders = Order.all
    else
      @orders = Event.orders
    end
  end

  def index
    @events = Event.all
  end
end
