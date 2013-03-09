require 'spec_helper'

describe "sessions/edit" do
  before(:each) do
    @session = assign(:session, stub_model(Session,
      :guid => "MyString",
      :system_id => 1,
      :system_process_id => 1,
      :start_time => 1,
      :exit_time => 1
    ))
  end

  it "renders the edit session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", session_path(@session), "post" do
      assert_select "input#session_guid[name=?]", "session[guid]"
      assert_select "input#session_system_id[name=?]", "session[system_id]"
      assert_select "input#session_system_process_id[name=?]", "session[system_process_id]"
      assert_select "input#session_start_time[name=?]", "session[start_time]"
      assert_select "input#session_exit_time[name=?]", "session[exit_time]"
    end
  end
end
