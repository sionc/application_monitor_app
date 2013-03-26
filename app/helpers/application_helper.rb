# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/helpers/application_helper.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

module ApplicationHelper

  # Converts seconds to hours 
  def to_hours seconds, round_to
    (seconds.to_f / 3600).round(round_to)
  end

end
