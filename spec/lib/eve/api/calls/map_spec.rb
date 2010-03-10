require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    it "should have multiple elements" do
      eve_api.map.sovereignty.should have_at_least(1).item
    end
  end
end
