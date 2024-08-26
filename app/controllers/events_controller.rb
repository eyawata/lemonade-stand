class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @orders = @event.orders
  end

  def index
    @events = Event.all
  end
end
