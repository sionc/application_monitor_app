class SessionLogEntry < ActiveRecord::Base
  attr_accessible :session_id, :time_recorded

  belongs_to :sessions
  has_many :session_log_entries
end
