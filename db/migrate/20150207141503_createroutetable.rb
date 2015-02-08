class Createroutetable < ActiveRecord::Migration
  def change
    create_table :trip_routes do |t|
      t.string :pointlat
      t.string :pointlong
      t.belongs_to :DriverTrip

      t.timestamps null: false
    end
   
  end
end

