class RenameValueInNumericDataItems < ActiveRecord::Migration
  def change
    change_table :numeric_data_items do |t|
      t.rename :value, :recorded_value
    end
  end
end
