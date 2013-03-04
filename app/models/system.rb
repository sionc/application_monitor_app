class System < ActiveRecord::Base
  attr_accessible :guid, :name
  
  has_many :sessions
  has_many :event_log_entries
end
