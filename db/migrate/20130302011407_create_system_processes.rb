class CreateSystemProcesses < ActiveRecord::Migration
  def change
    create_table :system_processes do |t|
      t.string :software_version
      t.string :name

      t.timestamps
    end
  end
end
