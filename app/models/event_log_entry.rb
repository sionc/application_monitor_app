class EventLogEntry < ActiveRecord::Base
  attr_accessible :message, :time_generated, :system_id, :source
  
  belongs_to :system
end
