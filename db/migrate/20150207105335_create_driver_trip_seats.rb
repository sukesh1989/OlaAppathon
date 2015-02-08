class CreateDriverTripSeats < ActiveRecord::Migration
  def change
    create_table :driver_trip_seats do |t|
      t.string :from
      t.string :to
      t.string :seatsoccupied

      t.timestamps null: false
    end
  end
end
