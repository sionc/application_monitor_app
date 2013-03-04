
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
end
