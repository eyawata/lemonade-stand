class ChangeUserIdInOrdersToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :user_id, false
  end
end
