# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/controllers/event_log_entries_controller.rb $
# $Revision: 40 $, $Date: 2013-03-15 10:00:57 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class EventLogEntriesController < ApplicationController
  
  before_filter :authenticate_user! , :except => [:upload]
  
  # GET /event_log_entries
  # GET /event_log_entries.json
  def index
    @event_log_entries = EventLogEntry.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_log_entries }
    end
  end

  # GET /event_log_entries/1
  # GET /event_log_entries/1.json
  def show
    @event_log_entry = EventLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_log_entry }
    end
  end

  # POST /upload_event_log_entries
  # POST /upload_event_log_entries.json
  def upload
    begin
      
      system_guid = params[:event_log_entries][:system_guid]
      raise "Failed to parse GUID parameter for system" if system_guid.nil?
      
      system = System.where(:guid => system_guid).first
      system = System.create({:guid => system_guid, :name => ("System " + system_guid)}) if system.nil?
      raise "Failed to create system" if system.nil?
    
      event_log_entries = params[:event_log_entries][:event_log_entry]
      event_log_entries.each do |entry|
        entry[:system_id] = system.id        
      end
    
    rescue Exception => ex 
    
      logger.error ex.message
    
    ensure

      respond_to do |format|
        if EventLogEntry.create(event_log_entries)
          format.html { render nothing: true, status: :ok }
        else
          format.html { render nothing: true, status: :unprocessable_entity  }
        end
      end

    end
    
  end
    
end
