require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    subject { mock_service('map', 'sovereignty').solar_systems }

    it "should behave like a Rowset" do
      subject.should behave_like_rowset("solarSystemID,allianceID,factionID,solarSystemName,corporationID")
    end
  end
end
