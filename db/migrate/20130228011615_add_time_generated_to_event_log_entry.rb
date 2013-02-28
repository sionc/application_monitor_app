class AddTimeGeneratedToEventLogEntry < ActiveRecord::Migration
  def change
    add_column :event_log_entries, :time_generated, :integer
  end
end
