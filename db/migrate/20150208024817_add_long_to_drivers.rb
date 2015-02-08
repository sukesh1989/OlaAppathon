class AddLongToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :long, :string
  end
end
