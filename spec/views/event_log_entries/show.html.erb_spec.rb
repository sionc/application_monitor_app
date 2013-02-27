require 'spec_helper'

describe "event_log_entries/show" do
  before(:each) do
    @event_log_entry = assign(:event_log_entry, stub_model(EventLogEntry,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
