class AddLongToDrivertrips < ActiveRecord::Migration
  def change
    add_column :driver_trips, :startlong, :string
     add_column :driver_trips,:endlong, :string
      add_column :driver_trips, :currentlong, :string
  end
end
