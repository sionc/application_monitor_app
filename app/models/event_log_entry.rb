class EventLogEntry < ActiveRecord::Base
  attr_accessible :message, :timestamp
end
