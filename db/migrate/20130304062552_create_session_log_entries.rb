class CreateSessionLogEntries < ActiveRecord::Migration
  def change
    create_table :session_log_entries do |t|
      t.integer :session_id
      t.integer :time_recorded

      t.timestamps
    end
  end
end
