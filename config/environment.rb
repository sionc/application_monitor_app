# Copyright � Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/config/environment.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ApplicationMonitorApp::Application.initialize!
