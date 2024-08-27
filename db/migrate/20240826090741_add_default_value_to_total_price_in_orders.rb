class AddDefaultValueToTotalPriceInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :orders, :total_price, 0
  end
end
