# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/models/numeric_data_item.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class NumericDataItem < ActiveRecord::Base
  attr_accessible :data_item_type_id, :session_log_entry_id, :recorded_value
  
  belongs_to :data_item_type
  belongs_to :session_log_entry
end
