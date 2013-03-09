require 'spec_helper'

describe "sessions/show" do
  before(:each) do
    @session = assign(:session, stub_model(Session,
      :guid => "Guid",
      :system_id => 1,
      :system_process_id => 2,
      :start_time => 3,
      :exit_time => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Guid/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
