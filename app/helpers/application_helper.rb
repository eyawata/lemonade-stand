module ApplicationHelper
  def set_order
    if current_user
      @order = current_user.orders.where(status: "incomplete").order(:created_at).last || Order.create(user: current_user)
    end
  end
end
