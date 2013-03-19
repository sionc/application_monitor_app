# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/app/controllers/event_log_entries_controller.rb $
# $Revision: 40 $, $Date: 2013-03-15 10:00:57 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

class EventLogEntriesController < ApplicationController
  # GET /event_log_entries
  # GET /event_log_entries.json
  def index
    @event_log_entries = EventLogEntry.all

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

  # GET /event_log_entries/new
  # GET /event_log_entries/new.json
  def new
    @event_log_entry = EventLogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_log_entry }
    end
  end

  # GET /event_log_entries/1/edit
  def edit
    @event_log_entry = EventLogEntry.find(params[:id])
  end

  # POST /event_log_entries
  # POST /event_log_entries.json
  def create
    @event_log_entry = EventLogEntry.new(params[:event_log_entry])

    respond_to do |format|
      if @event_log_entry.save
        format.html { redirect_to @event_log_entry, notice: 'Event log entry was successfully created.' }
        format.json { render json: @event_log_entry, status: :created, location: @event_log_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @event_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_log_entries/1
  # PUT /event_log_entries/1.json
  def update
    @event_log_entry = EventLogEntry.find(params[:id])

    respond_to do |format|
      if @event_log_entry.update_attributes(params[:event_log_entry])
        format.html { redirect_to @event_log_entry, notice: 'Event log entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_log_entries/1
  # DELETE /event_log_entries/1.json
  def destroy
    @event_log_entry = EventLogEntry.find(params[:id])
    @event_log_entry.destroy

    respond_to do |format|
      format.html { redirect_to event_log_entries_url }
      format.json { head :no_content }
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
