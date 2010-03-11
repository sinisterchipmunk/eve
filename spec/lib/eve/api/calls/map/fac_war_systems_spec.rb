require 'spec_helper'

describe Eve::API::Services::Map do
  context "#fac_war_systems" do
    subject { mock_service('map', 'fac_war_systems').solar_systems }

    it "should behave like a Rowset" do
      subject.should behave_like_rowset("solarSystemID,solarSystemName,occupyingFactionID,occupyingFactionName,contested")
    end
  end
end
