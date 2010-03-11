require 'spec_helper'

describe Eve::API::Services::Map do
  context "#kills" do
    @expected_columns = "solarSystemID,shipKills,factionKills,podKills".split(/,/)
    before(:each) { @result = mock_service('map', 'kills') }
    it_should_behave_like "any Rowset"

    it "produces a RowSet called :solar_systems" do
      @result.solar_systems.should be_kind_of(Eve::API::Response::Rowset)
    end
  end
end
