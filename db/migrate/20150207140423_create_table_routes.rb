class CreateTableRoutes < ActiveRecord::Migration
  def change
   

    create_table :driver_trip_routes do |t|
      t.string :pointlat
      t.string :pointlong
      t.belongs_to :DriverTrip, index: true

      t.timestamps null: false
    end
    add_foreign_key :driver_trip_routes, :DriverTrips
 
end

  
end
