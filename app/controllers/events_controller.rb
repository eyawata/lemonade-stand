class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @orders = @event.orders
    @products = Product.joins(order_products: { order: :event }).where(events: { id: @event.id })
    @products_names = @products.pluck(:name)
  end

  def index
    @events = Event.all
    @new_event = Event.new
  end

  def update
    assign
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      assign
      redirect_to events_path, notice: "Event was susuccessfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assign
    @events = Event.all
    @events.each do |event|
      event.assign_to_event
    end
  end

  def event_params
    params.require(:event).permit(:start_date, :end_date, :estimated_event_cost, :event_name, :photo)
  end
end
