
class PagesController < ApplicationController
  def dashboard
    from = params[:from]
    to = params[:to] 
  
    average_memory_usage_type = DataItemType.where(:name => "Average Memory Usage").first
    peak_memory_usage_type = DataItemType.where(:name => "Peak Memory Usage").first
    
    @statistics_summary = {}
    SystemProcess.find_each do |system_process|
      
      # Find all the sessions that are in range
      sessions = system_process.sessions_in_range(from, to)
      total_usage = 0
      active_usage = 0
      average_memory_usage_arr = []
      peak_memory_usage_arr = []
      
      sessions.each do |session|
       
         # Calculate total usage
         t_usage = 0
         t_usage = session.exit_time - session.start_time
         t_usage -= (start_time - from) if (start_time > from)
         t_usage -= (to - exit_time) if (exit_time < to)
         total_usage += t_usage
       
         # Calculate active usage
         active_usage += session.active_usage
       
         unless average_memory_usage_type.nil? AND peak_memory_usage_type.nil?
           session_log_entry_ids = session.session_log_entries.pluck(:id)
           
           # Calculate average memory usage
           unless average_memory_usage_type.nil?
             type_id = average_memory_usage_type.id
             usage_values = NumericDataItem.where(:session_log_entry_id => session_log_entry_ids, 
                                   :data_item_type_id => type_id).pluck(:recorded_value)
           
             average_memory_usage_arr.push(usage_values.inject{ |sum, el| sum + el }.to_f / usage_values.size)                                                      
           end
         
           # Calculate peak memory usage
          unless peak_memory_usage_type.nil?
            type_id = peak_memory_usage_type.id
            usage_values = NumericDataItem.where(:session_log_entry_id => session_log_entry_ids, 
                                  :data_item_type_id => type_id).pluck(:recorded_value)

            # Find average here...                       
            peak_memory_usage_arr.push(usage_values.max)  
          end
        
        end
      
      end
   
      average_memory_usage = average_memory_usage_arr.inject{ |sum, el| sum + el }.to_f / average_memory_usage_arr.size
      peak_memory_usage = peak_memory_usage_arr.max
      
      system_process_summary = {}
      system_process_summary["total_usage"] = total_usage
      system_process_summary["active_usage"] = active_usage
      system_process_summary["average_memory_usage"] = average_memory_usage
      system_process_summary["peak_memory_usage"] = peak_memory_usage
      
      @statistics_summary[system_process.name + " " + system_process.software_version] = system_process_summary
    end
            
    #total_usage_by_process = SystemProcess.total_usage(from, to)
    #active_usage_by_process = SystemProcess.active_usage(from, to)
    #number_of_crashes_by_process = SystemProcess.number_of_crashes(from, to)
    # systems_count_by_process = SystemProcess.systems_count 
    #     average_memory_usage_by_process = SystemProcess.average_memory_usage(from, to)
    #     peak_memory_usage_by_process = SystemProcess.peak_memory_usage(from, to)
  
    #total_usage_max_pair = total_usage_by_process.max_by{|key, value| value}
    #total_usage = 0
    #total_usage = total_usage_max_pair[1] unless (total_usage_max_pair.nil? || total_usage_max_pair.length < 2)
  
    # active_usage_max_pair = active_usage_by_process.max_by{|key, value| value}
    #     active_usage = 0
    #     active_usage = active_usage_max_pair[1] unless (active_usage_max_pair.nil? || active_usage_max_pair.length < 2)
    #   
    #     number_of_crashes = 0
    #     number_of_crashes_by_process.each do |key, value|
    #         number_of_crashes += value
    #     end
    #   
    #     number_of_systems = 0
    #     number_of_systems_by_process.each do |key, value|
    #         number_of_systems += value
    #     end
    #   
    #     number_of_exceptions = EventLogEntry.count(from, to)
    #  end
  end
