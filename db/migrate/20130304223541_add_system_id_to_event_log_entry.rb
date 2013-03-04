class AddSystemIdToEventLogEntry < ActiveRecord::Migration
  def change
    add_column :event_log_entries, :system_id, :integer
  end
end
