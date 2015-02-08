class CreateDriverTrips < ActiveRecord::Migration
  def change
    create_table :driver_trips do |t|
      t.string :start
      t.string :end
      t.string :isCurrent
      t.string :currentPosition
      t.belongs_to :Driver, index: true

      t.timestamps null: false
    end
    add_foreign_key :driver_trips, :Drivers
  end
end
