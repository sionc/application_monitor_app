class RenameTimestampInEvent < ActiveRecord::Migration
  def change
      change_table :event_log_entries do |t|
        t.rename :timestamp, :time_generated
      end
    end
end
