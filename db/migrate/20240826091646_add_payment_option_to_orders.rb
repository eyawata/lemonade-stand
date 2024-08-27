class AddPaymentOptionToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_option, :string
  end
end
