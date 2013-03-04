require "spec_helper"

describe SessionLogEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/session_log_entries").should route_to("session_log_entries#index")
    end

    it "routes to #new" do
      get("/session_log_entries/new").should route_to("session_log_entries#new")
    end

    it "routes to #show" do
      get("/session_log_entries/1").should route_to("session_log_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/session_log_entries/1/edit").should route_to("session_log_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/session_log_entries").should route_to("session_log_entries#create")
    end

    it "routes to #update" do
      put("/session_log_entries/1").should route_to("session_log_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/session_log_entries/1").should route_to("session_log_entries#destroy", :id => "1")
    end

  end
end
