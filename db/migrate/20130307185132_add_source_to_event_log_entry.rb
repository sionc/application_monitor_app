class AddSourceToEventLogEntry < ActiveRecord::Migration
  def change
    add_column :event_log_entries, :source, :string
  end
end
