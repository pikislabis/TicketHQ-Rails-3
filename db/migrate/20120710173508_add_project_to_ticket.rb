class AddProjectToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :project_id, :integer
  end
end
