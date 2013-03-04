
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
    event_log_entries = params[:event_log_entries][:event_log_entry]

    respond_to do |format|
      if EventLogEntry.create(event_log_entries)
        format.html { render nothing: true, status: :ok }
      else
        format.html { render nothing: true, status: :unprocessable_entity  }
      end
    end
  end
    
end
