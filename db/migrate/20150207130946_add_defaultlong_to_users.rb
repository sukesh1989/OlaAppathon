class AddDefaultlongToUsers < ActiveRecord::Migration
  def change
    add_column :users, :defaultlong, :string
  end
end
