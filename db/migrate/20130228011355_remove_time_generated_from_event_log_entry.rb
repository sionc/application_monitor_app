class RemoveTimeGeneratedFromEventLogEntry < ActiveRecord::Migration
  def up
    remove_column :event_log_entries, :time_generated
  end

  def down
    add_column :event_log_entries, :time_generated, :datetime
  end
end
