class AddLocationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :location, :string
  end
end
