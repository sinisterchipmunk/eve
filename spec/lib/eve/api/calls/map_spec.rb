require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    before(:each) { mock_service('map', 'sovereignty') }
    it "should have multiple elements" do
      eve_api.map.sovereignty.should have_at_least(1).item
    end
  end

  context "#kills" do
    before(:each) { mock_service('map', 'kills') }
    it "should have multiple elements" do
      eve_api.map.kills.should have_at_least(1).item
    end
  end

  context "#jumps" do
    before(:each) { mock_service('map', 'jumps') }
    it "should have multiple elements" do
      eve_api.map.jumps.should have_at_least(1).item
    end
  end

  context "#fac_war_systems" do
    before(:each) { mock_service('map', 'fac_war_systems') }
    it "should have multiple elements" do
      eve_api.map.fac_war_systems.should have_at_least(1).item
    end
  end
end
