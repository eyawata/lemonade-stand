class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @orders = @event.orders
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
    assign
    if @event.save
      redirect_to events_path, notice: "Event was susuccessfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assign
    # todo
    # iterate through the events
    # calls order instance method
  end

  def event_params
    params.require(:event).permit(:start_date, :end_date, :estimated_event_cost, :event_name, :photo)
  end
end
