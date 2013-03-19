# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/models/system_process.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class SystemProcess < ActiveRecord::Base
  attr_accessible :name, :software_version, :sessions_in_range
  
  has_many :sessions
  
  # Gets all the sessions that are within the specified range
  def sessions_in_range (from, to)  
    sessions = self.sessions.where("start_time < ? AND exit_time > ?", to, from)
  end
end
