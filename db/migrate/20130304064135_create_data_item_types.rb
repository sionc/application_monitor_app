class CreateDataItemTypes < ActiveRecord::Migration
  def change
    create_table :data_item_types do |t|
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
