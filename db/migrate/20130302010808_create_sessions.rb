class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :guid
      t.integer :system_id
      t.integer :process_id
      t.integer :start_time
      t.integer :exit_time

      t.timestamps
    end
  end
end
