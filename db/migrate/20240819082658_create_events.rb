class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.date :start_date
      t.date :end_date
      t.float :estimated_event_cost
      t.string :event_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
