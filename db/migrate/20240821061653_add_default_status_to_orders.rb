class AddDefaultStatusToOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :orders, :status, "incompleted"
  end
end
