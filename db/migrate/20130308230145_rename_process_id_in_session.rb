class RenameProcessIdInSession < ActiveRecord::Migration
  def change
      change_table :sessions do |t|
        t.rename :process_id, :system_process_id
      end
  end
end
