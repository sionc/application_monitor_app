require 'spec_helper'

describe "session_log_entries/edit" do
  before(:each) do
    @session_log_entry = assign(:session_log_entry, stub_model(SessionLogEntry,
      :session_id => 1,
      :time_recorded => 1
    ))
  end

  it "renders the edit session_log_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", session_log_entry_path(@session_log_entry), "post" do
      assert_select "input#session_log_entry_session_id[name=?]", "session_log_entry[session_id]"
      assert_select "input#session_log_entry_time_recorded[name=?]", "session_log_entry[time_recorded]"
    end
  end
end
