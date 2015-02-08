class CreateBookingfinals < ActiveRecord::Migration
  def change
    create_table :bookingfinals do |t|
      t.string :useremail
      t.string :tripid

      t.timestamps null: false
    end
  end
end
