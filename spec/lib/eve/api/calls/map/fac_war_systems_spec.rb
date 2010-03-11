require 'spec_helper'

describe Eve::API::Services::Map do
  context "#fac_war_systems" do
    @expected_columns = "solarSystemID,solarSystemName,occupyingFactionID,occupyingFactionName,contested".split(/,/)
    before(:each) { @result = mock_service('map', 'fac_war_systems') }
    it_should_behave_like "any Rowset"

    it "should have multiple elements" do
      @result.should have_at_least(1).item
    end
  end
end
