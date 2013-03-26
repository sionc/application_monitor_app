# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/controllers/pages_controller.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class PagesController < ApplicationController
  
  # GET /pages/dashboard
  def dashboard
    from = params[:from]
    to = params[:to]
    
    # If from and to parameters are not provided, then use
    current_utc_time = Time.now.utc
    to = current_utc_time.to_i if to.nil?
    from  = (current_utc_time - 1.month).to_i if from.nil?  
  
    # Get the data item type records
    average_memory_usage_type = DataItemType.where(:name => "Average Memory Usage").first
    peak_memory_usage_type = DataItemType.where(:name => "Peak Memory Usage").first
    
    statistics_summary_by_process_type = {}
    statistics_details_by_app_version = {}
    
    # Find all registered processes
    SystemProcess.find_each do |system_process|
      
      # Find all the sessions that are in range
      sessions = system_process.sessions_in_range(from, to)
      total_usage = 0
      active_usage = 0
      active_systems = []
      average_memory_usage_arr = []
      peak_memory_usage_arr = []
      
      # Loop through all the sessions for this process that are in the date range
      sessions.each do |session|
         
         # Keep track of the ids of the systems that have sessions in the date range
         system_id = session.system.id
         active_systems << system_id unless active_systems.include? system_id
        
         # Calculate total usage
         start_time = session.start_time
         exit_time = session.exit_time.nil? ? start_time : session.exit_time
         t_usage = 0
         if (start_time < to) && (exit_time > from) 
           t_usage = exit_time - start_time
           t_usage -= (from - start_time) if (from > start_time)
           t_usage -= (exit_time - to) if (exit_time > to)
           total_usage += t_usage
         end
       
         # Calculate active usage
         active_usage += session.active_usage unless session.active_usage.nil?
       
         unless average_memory_usage_type.nil? && peak_memory_usage_type.nil?
           session_log_entry_ids = session.session_log_entries.pluck(:id)
           
           # Calculate average memory usage
           unless average_memory_usage_type.nil?
             usage_values = average_memory_usage_type.numeric_data_items.where(:session_log_entry_id => session_log_entry_ids)
                                                                        .pluck(:recorded_value)         
             num_values = usage_values.nil? ? 0 : usage_values.size 
             logger.debug usage_values.inspect
             average_memory_usage_arr.push(usage_values.inject{ |sum, el| sum + el }.to_f / num_values) if (num_values > 0)                                                     
           end
         
           # Calculate peak memory usage
          unless peak_memory_usage_type.nil?
            type_id = peak_memory_usage_type.id
            usage_values = NumericDataItem.where(:session_log_entry_id => session_log_entry_ids, 
                                  :data_item_type_id => type_id).pluck(:recorded_value)
            
            # Find max
            num_values = usage_values.nil? ? 0 : usage_values.size                        
            peak_memory_usage_arr.push(usage_values.max) if (num_values > 0) 
          end
        
        end
      
      end
      
      # Calculate the average memory usage
      arr_size = average_memory_usage_arr.size
      average_memory_usage = (arr_size > 0) ? (average_memory_usage_arr.inject{ |sum, el| sum + el }.to_f / arr_size) : 0
      
      # Calculate the peak memory usage
      arr_size = peak_memory_usage_arr.size
      peak_memory_usage = (arr_size > 0) ? peak_memory_usage_arr.max : 0
      
      # Create the hash containing the summary of statistics by version
      system_process_summary = {}
      system_process_summary["Total Usage"] = total_usage
      system_process_summary["Active Usage"] = active_usage
      system_process_summary["Average Memory Usage"] = average_memory_usage.round
      system_process_summary["Peak Memory Usage"] = peak_memory_usage.round
      system_process_summary["Active Systems"] = active_systems
      
      process_name = system_process.name
      version = system_process.software_version
      app_version = (process_name.start_with?("Ace") ? "Ace" : process_name) + " " + version
      statistics_details_by_app_version[app_version] = {} if statistics_details_by_app_version[app_version].nil?
      statistics_details_by_app_version[app_version][process_name] = system_process_summary
    end
    
    # Create a summary based on the process type
    statistics_details_by_app_version.each do |app_version, statistics_by_process_name| 
      statistics_by_process_name.each do |name, statistics|
        statistics_summary_by_process_type[name] = {} if statistics_summary_by_process_type[name].nil?
        statistics_summary = statistics_summary_by_process_type[name]
        
        statistics_summary["Total Usage"] = 0 if statistics_summary["Total Usage"].nil?
        statistics_summary["Total Usage"] += statistics["Total Usage"]
        
        statistics_summary["Active Usage"] = 0 if statistics_summary["Active Usage"].nil?
        statistics_summary["Active Usage"] += statistics["Active Usage"]
        
        statistics_summary["Active Systems Count"] = 0 if statistics_summary["Active Systems"].nil?
        statistics_summary["Active Systems Count"] += statistics["Active Systems"].length        
      end
    end
    
    # Create a hash for the event summary
    sessions_count = 0
    exceptions_count = 0
    systems  = System.all   
    unless systems.nil?
      systems.each do |system|
        sessions_count += system.sessions_count(from, to)
        exceptions_count += system.event_log_entries_count(from, to)
      end
    end
    event_summary = {}
    event_summary["Sessions Count"] = sessions_count
    event_summary["Exceptions Count"] = exceptions_count
    
    @statistics = {}
    @statistics["Summary"] = statistics_summary_by_process_type
    @statistics["Summary"]["Sessions Count"] = sessions_count
    @statistics["Summary"]["Exceptions Count"] = exceptions_count
    @statistics["Details"] = statistics_details_by_app_version
    
    respond_to do |format|
      format.html # dashboard.html.erb
      format.json { render json: @statistics }
    end        
    
  end
  
end
