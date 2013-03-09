class SystemProcess < ActiveRecord::Base
  attr_accessible :name, :software_version, :sessions_in_range
  
  has_many :sessions
  
  # Gets all the sessions that are within the specified range
  def sessions_in_range (from, to)  
    sessions = self.sessions.where("start_time < ? AND exit_time > ?", to, from)
  end
end
