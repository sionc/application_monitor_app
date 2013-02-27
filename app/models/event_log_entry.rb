class EventLogEntry < ActiveRecord::Base
  attr_accessible :message, :time_generated
end
