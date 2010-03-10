require 'spec_helper'

describe Eve::API::Services::Map do
  context "#fac_war_systems" do
    before(:each) { mock_service('map', 'fac_war_systems') }
    it "should have multiple elements" do
      eve_api.map.fac_war_systems.should have_at_least(1).item
    end
  end
end
