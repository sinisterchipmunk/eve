require 'spec_helper'

describe Eve::API::Services::Map do
  context "#jumps" do
    before(:each) { mock_service('map', 'jumps') }
    it "should have multiple elements" do
      eve_api.map.jumps.should have_at_least(1).item
    end
  end
end
