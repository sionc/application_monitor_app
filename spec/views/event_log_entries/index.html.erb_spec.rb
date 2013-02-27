require 'spec_helper'

describe "event_log_entries/index" do
  before(:each) do
    assign(:event_log_entries, [
      stub_model(EventLogEntry,
        :message => "MyText"
      ),
      stub_model(EventLogEntry,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of event_log_entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
