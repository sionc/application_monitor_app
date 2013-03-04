require 'spec_helper'

describe "session_log_entries/index" do
  before(:each) do
    assign(:session_log_entries, [
      stub_model(SessionLogEntry,
        :session_id => 1,
        :time_recorded => 2
      ),
      stub_model(SessionLogEntry,
        :session_id => 1,
        :time_recorded => 2
      )
    ])
  end

  it "renders a list of session_log_entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
