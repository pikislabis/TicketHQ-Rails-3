class AddNotifPreferenceUser < ActiveRecord::Migration
  def change
  	add_column :users, :notification_preference, :string, :default => "inmediatly"
  end
end
