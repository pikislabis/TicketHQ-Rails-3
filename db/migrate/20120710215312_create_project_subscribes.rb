class CreateProjectSubscribes < ActiveRecord::Migration
  def self.up
    create_table :project_subscribes do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :project_subscribes
  end
end
