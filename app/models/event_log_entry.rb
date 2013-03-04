class EventLogEntry < ActiveRecord::Base
  attr_accessible :message, :time_generated, :system_id
  
  belongs_to :system
end
