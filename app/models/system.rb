# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/models/system.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class System < ActiveRecord::Base
  attr_accessible :guid, :name
  
  has_many :sessions
  has_many :event_log_entries
  
  # Gets the total number of sessions within the specified range
  def sessions_count(from, to)
    self.sessions_in_range(from, to).count
  end
  
  # Gets all the sessions that are within the specified range
  def sessions_in_range(from, to)  
    sessions = self.sessions.where("start_time < ? AND exit_time > ?", to, from)
  end
  
  # Gets the total number of event log entries within the specified range
  def event_log_entries_count(from, to)
    self.event_log_entries_in_range(from, to).count
  end
  
  # Gets all the events that are within the specified range
  def event_log_entries_in_range(from, to)  
    sessions = self.event_log_entries.where(:time_generated => from..to)
  end
  
  
end
