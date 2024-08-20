class MakeEventIdOptionalInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :event_id, true
  end
end
