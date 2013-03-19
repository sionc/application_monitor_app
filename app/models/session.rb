# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/models/session.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class Session < ActiveRecord::Base
  attr_accessible :exit_time, :guid, :system_process_id, :start_time, :system_id, :active_usage

  belongs_to :system
  belongs_to :system_process
  has_many :session_log_entries

end
