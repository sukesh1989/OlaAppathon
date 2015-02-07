class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :mobile
      t.string :source
      t.string :device_id
      t.string :default_location

      t.timestamps null: false
    end
  end
end
