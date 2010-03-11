# outposts - "stationID,stationName,stationTypeID,solarSystemID,corporationID,corporationName"
require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#conquerable_station_list" do
    subject { mock_service(:eve, :conquerable_station_list).outposts }

    it "follows expected structure" do
      subject.should behave_like_rowset("stationID,stationName,stationTypeID,solarSystemID,corporationID,corporationName")
    end
  end
end
