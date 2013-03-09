require 'spec_helper'

describe "sessions/new" do
  before(:each) do
    assign(:session, stub_model(Session,
      :guid => "MyString",
      :system_id => 1,
      :system_process_id => 1,
      :start_time => 1,
      :exit_time => 1
    ).as_new_record)
  end

  it "renders new session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sessions_path, "post" do
      assert_select "input#session_guid[name=?]", "session[guid]"
      assert_select "input#session_system_id[name=?]", "session[system_id]"
      assert_select "input#session_process_id[name=?]", "session[process_id]"
      assert_select "input#session_start_time[name=?]", "session[start_time]"
      assert_select "input#session_exit_time[name=?]", "session[exit_time]"
    end
  end
end
