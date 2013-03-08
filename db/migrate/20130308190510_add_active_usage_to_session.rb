class AddActiveUsageToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :active_usage, :integer
  end
end
