class DataItemType < ActiveRecord::Base
  attr_accessible :name, :unit
  
  has_many :numeric_data_items
end
