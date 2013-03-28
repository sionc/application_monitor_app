# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/controllers/event_log_entries_controller.rb $
# $Revision: 40 $, $Date: 2013-03-15 10:00:57 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a_user = User.where(:email => "admin@admin.com")
if a_user.nil?
  u = User.new(:email => "admin@admin.com", :password => 'robots')
  u.save!(:validate => false)
end