class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
    @new_event = Event.new
  end

  def update
    assign
  end

  def create
    assign
  end

  private

  def assign
    # todo
    # iterate through the events
    # calls order instance method
  end
end
