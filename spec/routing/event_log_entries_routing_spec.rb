require "spec_helper"

describe EventLogEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/event_log_entries").should route_to("event_log_entries#index")
    end

    it "routes to #new" do
      get("/event_log_entries/new").should route_to("event_log_entries#new")
    end

    it "routes to #show" do
      get("/event_log_entries/1").should route_to("event_log_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_log_entries/1/edit").should route_to("event_log_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_log_entries").should route_to("event_log_entries#create")
    end

    it "routes to #update" do
      put("/event_log_entries/1").should route_to("event_log_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_log_entries/1").should route_to("event_log_entries#destroy", :id => "1")
    end

  end
end
