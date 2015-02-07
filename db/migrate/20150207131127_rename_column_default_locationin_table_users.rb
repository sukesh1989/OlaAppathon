class RenameColumnDefaultLocationinTableUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :default_location, :defaultlat
  end
end
