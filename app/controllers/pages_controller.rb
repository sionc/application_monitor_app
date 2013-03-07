
class PagesController < ApplicationController
  def dashboard
    from = params[:from]
    to = params[:to] 
    
    total_usage_by_process = SystemProcess.total_usage(from, to)
    active_usage_by_process = SystemProcess.active_usage(from, to)
    number_of_crashes_by_process = SystemProcess.number_of_crashes(from, to)
    number_of_systems_by_process = SystemProcess.number_of_systems(from, to) 
    avg_memory_usage_by_process = SystemProcess.avg_memory_usage(from, to)
    peak_memory_usage_by_process = SystemProcess.peak_memory_usage(from, to)
    
    total_usage_max_pair = total_usage_by_process.max_by{|key, value| value}
    total_usage = 0
    total_usage = total_usage_max_pair[1] unless (total_usage_max_pair.nil? || total_usage_max_pair.length < 2)
    
    active_usage_max_pair = active_usage_by_process.max_by{|key, value| value}
    active_usage = 0
    active_usage = active_usage_max_pair[1] unless (active_usage_max_pair.nil? || active_usage_max_pair.length < 2)
    
    number_of_crashes = 0
    number_of_crashes_by_process.each do |key, value|
        number_of_crashes += value
    end
    
    number_of_systems = 0
    number_of_systems_by_process.each do |key, value|
        number_of_systems += value
    end
    
    number_of_exceptions = EventLogEntry.count(from, to)
  end
end
