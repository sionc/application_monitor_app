class CreateNumericDataItems < ActiveRecord::Migration
  def change
    create_table :numeric_data_items do |t|
      t.integer :data_item_type_id
      t.integer :session_log_entry_id
      t.float :value

      t.timestamps
    end
  end
end
