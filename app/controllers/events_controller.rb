class EventsController < ApplicationController
  before_action :authenticate_user!
  def show
    if Order.last&.status == "incomplete"
      @order = Order.last
    else
      @order = Order.new
      @order.save
    end

    @event = Event.find(params[:id])
    @orders = @event.orders

    @total_earnings = @orders.sum{ |order| order.total_price }

    # get top three selling products (by qty sold)
    # all products in event
    @products = current_user.products.joins(order_products: { order: :event }).where(events: { id: @event.id }).uniq
    # iterate over products
    @product_quantities = @products.map do |product|
      [product, product.order_products.sum {|op| op.product_quantity }]
    end
    @product_quantities.sort_by! {|pair| pair[1]}.reverse!
    @top_three = @product_quantities.take(3)

    @net_profit = @total_earnings - @event.estimated_event_cost

    @out_of_stock = @products.select { |product| product.quantity == 0 }
  end

  def index
    @events = current_user.events
    @new_event = Event.new
    @order = Order.where(status: "incomplete").last
    @current_page = 'events'
    assign #added assign method to be called whenever events index is being rendered.
  end

  def update
    @edit_event = Event.find(params[:id])
    if @edit_event.update(event_params)
      assign
      redirect_to events_path, notice: "Event was successfully updated"
    else
      redirect_to events_path, notice: "Event was not successfully updated"
      #todo: build a standalon edit page for the redirect
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      assign
      redirect_to events_path, notice: "Event was successfully created"
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
