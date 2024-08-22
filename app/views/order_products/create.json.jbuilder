json.total render(partial: "orders/show_order", formats: :html, locals: {order: @order})
json.form render(partial: "orders/form", formats: :html, locals: {})
