require 'spec_helper'

describe "sessions/index" do
  before(:each) do
    assign(:sessions, [
      stub_model(Session,
        :guid => "Guid",
        :system_id => 1,
        :system_process_id => 2,
        :start_time => 3,
        :exit_time => 4
      ),
      stub_model(Session,
        :guid => "Guid",
        :system_id => 1,
        :system_process_id => 2,
        :start_time => 3,
        :exit_time => 4
      )
    ])
  end

  it "renders a list of sessions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
