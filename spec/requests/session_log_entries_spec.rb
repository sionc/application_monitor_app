require 'spec_helper'

describe "SessionLogEntries" do
  describe "GET /session_log_entries" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get session_log_entries_path
      response.status.should be(200)
    end
  end
end
