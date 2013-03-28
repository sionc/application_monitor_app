# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/controllers/session_log_entries_controller.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class SessionLogEntriesController < ApplicationController

  before_filter :authenticate_user! , :except => [:upload]

  # GET /session_log_entries
  # GET /session_log_entries.json
  def index
    @session_log_entries = SessionLogEntry.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @session_log_entries }
    end
  end

  # GET /session_log_entries/1
  # GET /session_log_entries/1.json
  def show
    @session_log_entry = SessionLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session_log_entry }
    end
  end
  
  # POST /upload_session_log_entries
  # POST /upload_session_log_entries.json
  def upload
    completed = false;
    
    begin 
      
      # Parse the session associated with the log entry
      log_entry_session = params[:session_log_entries][:session]
      raise "Failed to parse session data from log entries" if log_entry_session.nil?
      
      # Parse system GUID
      system_guid = log_entry_session[:system_guid]
      raise "Failed to parse GUID parameter for system" if system_guid.nil?
      
      # Get system
      system = System.where(:guid => system_guid).first
      
      # Create system if it does not already exist
      system = System.create({:guid => system_guid, :name => ("System " + system_guid)}) if system.nil?
      raise "Failed to create system" if system.nil? 
    
      # Get session
      session_guid = log_entry_session[:guid]
      raise "Failed to parse GUID parameter for session" if session_guid.nil?
      
      session = Session.where(:guid => session_guid).first
    
      # If session does not exist, then create it
      if session.nil?
        process_name =  log_entry_session[:process_name]
        raise "Failed to parse process name parameter for session" if process_name.nil?
        
        software_version = log_entry_session[:software_version]
        raise "Failed to parse software version parameter for session" if software_version.nil?
      
        # Check to see whether the system process exists
        session_process = SystemProcess.where(:name => process_name, 
                                              :software_version => software_version).first
      
        # If system process does not exist, then create it
        session_process = SystemProcess.create({:name => process_name, :software_version => software_version}) if session_process.nil?
        raise "Failed to create system process for session" if session_process.nil?
      
        # Create session
        start_time = log_entry_session[:start_time]
        session = Session.create({:guid => session_guid, 
                                  :system_process_id => session_process.id, 
                                  :start_time => start_time,
                                  :system_id => system.id})
        raise "Failed to create session for log entries" if session.nil?
      end
    
      session_log_entries_param = params[:session_log_entries][:session_log_entry]     
      session_log_entries = Array.new
      
      # If there are multiple entries, session log entries will already be an array.      
      # If there is a single entry, it will be sent in the form of a hash, so we need 
      # to convert it to an array
      if session_log_entries_param.kind_of?(Array)
        session_log_entries = session_log_entries_param
      else
        session_log_entries[0] = session_log_entries_param
      end
      
      # For each session log entry in array
      session_log_entries.each do |entry|
        time_recorded = entry[:time_recorded]
        raise "Failed to parse time recorded parameter for log entry" if time_recorded.nil?
        
        # Check wheter an entry already exists
        session_log_entry = SessionLogEntry.where(:session_id => session.id, :time_recorded => time_recorded).first

        # Cannot update a log entry once it has been created, so move to the next entry
        next unless session_log_entry.nil?
        
        entry[:session_id] = session.id
        
        # Make a copy of numeric data items
        numeric_data_item_param = entry[:numeric_data_item].clone
      
        # Delete the numeric data items from the entry
        entry.delete(:numeric_data_item)
        
        # Create a session log entry record
        session_log_entry = SessionLogEntry.create(entry) if session_log_entry.nil?
        raise "Failed to create session log entry" if session_log_entry.nil?
      
        # If there are multiple numeric data item entries, numeric_data_items_param will already 
        # be an array.      
        # If there is a single entry, it will be sent in the form of a hash, so we need to convert
        # it to an array.
        numeric_data_items = Array.new
        if numeric_data_item_param.kind_of?(Array)
          numeric_data_items = numeric_data_item_param
        else
          numeric_data_items[0] = numeric_data_item_param
        end
      
        # For each numeric data item
        numeric_data_items.each do |item|
          type_name = item[:name]
          raise "Failed to parse name of data item type" if type_name.nil?
          
          type_unit = item[:unit]
          
          data_item_type = DataItemType.where(:name => type_name, :unit => type_unit).first

          # If a numeric data item type does not exist then create it
          data_item_type = DataItemType.create({:name => type_name, :unit => type_unit}) if data_item_type.nil?
          raise "Failed to create data item type" if data_item_type.nil? 
        
          recorded_value = item[:recorded_value]
          raise "Failed to parse recorded value for numeric data item" if recorded_value.nil?
          
          numeric_data_item = NumericDataItem.create({:session_log_entry_id => session_log_entry.id,
                                                      :data_item_type_id => data_item_type.id,
                                                      :recorded_value => recorded_value})
          raise "Failed to create numeric data item" if numeric_data_item.nil?                                           
        end
      end
    
      # Check whether active_usage needs to be updated. 
      # If yes, then add the active usage seconds to the current active usage value.
      active_usage = log_entry_session[:active_usage]
      unless active_usage.nil?
        current_active_usage = session.active_usage.nil? ? 0 : session.active_usage
        new_active_usage = current_active_usage + active_usage.to_i
        raise "Failed to update active usage for session" unless session.update_attributes(:active_usage => new_active_usage)
      end   
    
      # Check whether session has an exit time. 
      # If yes, then update the attribute
      exit_time = log_entry_session[:exit_time]
      unless exit_time.nil?       
        raise "Failed to update exit time for session" unless session.update_attributes(:exit_time => exit_time)
      end
    
      completed = true;
      
    rescue Exception => ex 
      
      logger.error ex.message
    
    ensure
      
      respond_to do |format|
        if completed
          format.html { render nothing: true, status: :ok }
        else
          format.html { render nothing: true, status: :unprocessable_entity }
        end
      end
      
    end
  end
  
end
