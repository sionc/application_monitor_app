class CreateEventLogEntries < ActiveRecord::Migration
  def change
    create_table :event_log_entries do |t|
      t.text :message
      t.datetime :timestamp

      t.timestamps
    end
  end
end
