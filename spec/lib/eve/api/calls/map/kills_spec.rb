require 'spec_helper'

describe Eve::API::Services::Map do
  context "#kills" do
    before(:each) { mock_service('map', 'kills') }
    it "should have multiple elements" do
      eve_api.map.kills.should have_at_least(1).item
    end
  end
end
