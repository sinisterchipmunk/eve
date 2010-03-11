require 'spec_helper'

describe Eve::API::Services::Map do
  context "#jumps" do
    @expected_columns = "solarSystemID,shipJumps".split(/,/)
    before(:each) { @result = mock_service('map', 'jumps') }
    it_should_behave_like "any Rowset"

    it "should have multiple elements" do
      @result.should have_at_least(1).item
    end
  end
end
