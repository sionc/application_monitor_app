class SessionLogEntry < ActiveRecord::Base
  attr_accessible :session_id, :time_recorded

  belongs_to :sessions
  has_many :numeric_data_items
end
