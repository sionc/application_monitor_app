class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :guid
      t.string :name

      t.timestamps
    end
  end
end
