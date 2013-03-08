class Session < ActiveRecord::Base
  attr_accessible :exit_time, :guid, :process_id, :start_time, :system_id, :active_usage

  belongs_to :system
  belongs_to :system_process
  has_many :session_log_entries

end
