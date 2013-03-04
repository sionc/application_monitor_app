class SystemProcess < ActiveRecord::Base
  attr_accessible :name, :software_version
  
  has_many :sessions
end
