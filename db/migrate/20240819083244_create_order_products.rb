class CreateOrderProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_products do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :product_quantity
      t.references :order, null: false, foreign_key: true
      t.float :product_price_at_sale

      t.timestamps
    end
  end
end
