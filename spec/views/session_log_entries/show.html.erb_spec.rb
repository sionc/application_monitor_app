require 'spec_helper'

describe "session_log_entries/show" do
  before(:each) do
    @session_log_entry = assign(:session_log_entry, stub_model(SessionLogEntry,
      :session_id => 1,
      :time_recorded => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
