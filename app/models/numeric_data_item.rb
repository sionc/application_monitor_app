class NumericDataItem < ActiveRecord::Base
  attr_accessible :data_item_type_id, :session_log_entry_id, :value
end
