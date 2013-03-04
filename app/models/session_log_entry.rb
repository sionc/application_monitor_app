class SessionLogEntry < ActiveRecord::Base
  attr_accessible :session_id, :time_recorded
end
