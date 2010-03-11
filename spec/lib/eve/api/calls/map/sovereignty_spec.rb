require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    before(:each) { @result = mock_service('map', 'sovereignty') }
    @expected_columns = "solarSystemID,allianceID,factionID,solarSystemName,corporationID".split(/,/)
    it_should_behave_like "any Rowset"

    it "creates a RowSet called :solar_systems" do
      @result.should respond_to(:solar_systems)
    end

    it "produces 10 rows in the RowSet" do
      @result.solar_systems.should have(10).systems
    end
  end
end
