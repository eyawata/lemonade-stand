class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.float :total_price
      t.references :event, null: false, foreign_key: true
      t.integer :order_discount
      t.string :status

      t.timestamps
    end
  end
end
