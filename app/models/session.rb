class Session < ActiveRecord::Base
  attr_accessible :exit_time, :guid, :process_id, :start_time, :system_id
end
