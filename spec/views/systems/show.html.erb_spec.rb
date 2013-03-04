require 'spec_helper'

describe "systems/show" do
  before(:each) do
    @system = assign(:system, stub_model(System,
      :guid => "Guid",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Guid/)
    rendered.should match(/Name/)
  end
end
