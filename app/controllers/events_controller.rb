class EventsController < ApplicationController
  before_action :authenticate_user!
  def show
    if Order.last&.status == "incomplete"
      @order = Order.last
    else
      @order = Order.new
      @order.save
    end

    @event = current_user.events.find(params[:id])
    @orders = @event.orders

    @total_earnings = @orders.sum{ |order| order.total_price }

    # get top three selling products (by qty sold)
    # all products in event
    @products = current_user.products.joins(order_products: { order: :event }).where(events: { id: @event.id }).uniq
    # iterate over products
    @product_quantities = @products.map do |product|
      [product, @event.order_products.where(product: product).sum {|op| op.product_quantity }]
    end
    @product_quantities.sort_by! {|pair| pair[1]}.reverse!
    @top_three = @product_quantities.take(3)

    if @event.estimated_event_cost.nil?
      @net_profit = @total_earnings
    else
      @net_profit = @total_earnings - @event.estimated_event_cost
    end
    @out_of_stock = @products.select { |product| product.quantity == 0 }
  end

  def index
    @events = current_user.events
    @new_event = Event.new
    @order = Order.where(status: "incomplete").last
    @current_page = 'events'
  end

  def update
    @edit_event = Event.find(params[:id])
    if @edit_event.update(event_params)
      assign(@edit_event)
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
      assign(@event)
      redirect_to events_path, notice: "Event was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assign(event)
    event.assign_to_event
  end

  def event_params
    params.require(:event).permit(:start_date, :end_date, :estimated_event_cost, :event_name, :location, :photo)
  end
end
