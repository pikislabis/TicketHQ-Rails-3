class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :name, :string
    add_column :users, :admin, :boolean, :default => false
  end
end
