require 'spec_helper'

describe Eve::API::Services::Map do
  context "#jumps" do
    subject { mock_service('map', 'jumps').solar_systems }

    it "should behave like a Rowset" do
      subject.should behave_like_rowset('solarSystemID,shipJumps')
    end
  end
end
