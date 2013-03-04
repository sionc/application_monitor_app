class NumericDataItem < ActiveRecord::Base
  attr_accessible :data_item_type_id, :session_log_entry_id, :recorded_value
  
  belongs_to :data_item_type
  belongs_to :session_log_entry
end
