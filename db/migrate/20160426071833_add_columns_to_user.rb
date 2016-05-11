class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :Firstname, :string
    add_column :users, :lastname, :string
  end
end
