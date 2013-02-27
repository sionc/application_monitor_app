require 'spec_helper'

describe "event_log_entries/edit" do
  before(:each) do
    @event_log_entry = assign(:event_log_entry, stub_model(EventLogEntry,
      :message => "MyText"
    ))
  end

  it "renders the edit event_log_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_log_entry_path(@event_log_entry), "post" do
      assert_select "textarea#event_log_entry_message[name=?]", "event_log_entry[message]"
    end
  end
end
