
class SessionLogEntriesController < ApplicationController
  # GET /session_log_entries
  # GET /session_log_entries.json
  def index
    @session_log_entries = SessionLogEntry.all

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

  # GET /session_log_entries/new
  # GET /session_log_entries/new.json
  def new
    @session_log_entry = SessionLogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session_log_entry }
    end
  end

  # GET /session_log_entries/1/edit
  def edit
    @session_log_entry = SessionLogEntry.find(params[:id])
  end

  # POST /session_log_entries
  # POST /session_log_entries.json
  def create
    @session_log_entry = SessionLogEntry.new(params[:session_log_entry])

    respond_to do |format|
      if @session_log_entry.save
        format.html { redirect_to @session_log_entry, notice: 'Session log entry was successfully created.' }
        format.json { render json: @session_log_entry, status: :created, location: @session_log_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @session_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /session_log_entries/1
  # PUT /session_log_entries/1.json
  def update
    @session_log_entry = SessionLogEntry.find(params[:id])

    respond_to do |format|
      if @session_log_entry.update_attributes(params[:session_log_entry])
        format.html { redirect_to @session_log_entry, notice: 'Session log entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session_log_entries/1
  # DELETE /session_log_entries/1.json
  def destroy
    @session_log_entry = SessionLogEntry.find(params[:id])
    @session_log_entry.destroy

    respond_to do |format|
      format.html { redirect_to session_log_entries_url }
      format.json { head :no_content }
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
    
      # Get session
      guid = log_entry_session[:guid]
      raise "Failed to parse GUID parameter for session" if guid.nil?
      
      session = Session.where(:guid => guid).first
    
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
        session = Session.create({:guid => guid, :process_id => session_process.id, :start_time => start_time})
        raise "Failed to create session for log entries" if session.nil?
      end
    
      session_log_entries = params[:session_log_entries][:session_log_entry]
      
      # For each session log entry in array
      session_log_entries.each do |entry|
        time_recorded = entry[:time_recorded]
        raise "Failed to parse time recorded parameter for log entry" if time_recorded.nil?
        
        entry[:session_id] = session.id
        
        # Make a copy of numeric data items
        numeric_data_items = entry[:numeric_data_items].clone
      
        # Delete the numeric data items from the entry
        entry.delete(:numeric_data_items)
      
        # Create a session log entry record
        session_log_entry = SessionLogEntry.create(entry)
        raise "Failed to create session log entry" if session_log_entry.nil?
      
        # For each numeric data item
        numeric_data_items[:numeric_data_item].each do |item|
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
    
      # Check whether session has an exit time. 
      # If yes, then update the attribute
      exit_time = log_entry_session[:exit_time]
      updated_session = session.update_attributes(:exit_time => exit_time) unless exit_time.nil?
    
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
