class ChangeOrderToPositionInProject < ActiveRecord::Migration
  def self.up
    rename_column :statuses, :order, :position
  end
  
  def self.down
    rename_column :statuses, :position, :order
  end
end
