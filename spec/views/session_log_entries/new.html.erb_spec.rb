require 'spec_helper'

describe "session_log_entries/new" do
  before(:each) do
    assign(:session_log_entry, stub_model(SessionLogEntry,
      :session_id => 1,
      :time_recorded => 1
    ).as_new_record)
  end

  it "renders new session_log_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", session_log_entries_path, "post" do
      assert_select "input#session_log_entry_session_id[name=?]", "session_log_entry[session_id]"
      assert_select "input#session_log_entry_time_recorded[name=?]", "session_log_entry[time_recorded]"
    end
  end
end
