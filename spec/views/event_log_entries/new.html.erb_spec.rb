require 'spec_helper'

describe "event_log_entries/new" do
  before(:each) do
    assign(:event_log_entry, stub_model(EventLogEntry,
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new event_log_entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_log_entries_path, "post" do
      assert_select "textarea#event_log_entry_message[name=?]", "event_log_entry[message]"
    end
  end
end
