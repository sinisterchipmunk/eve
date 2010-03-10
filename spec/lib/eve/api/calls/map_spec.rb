require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    it "should have multiple elements" do
      eve_api.map.sovereignty.should have_at_least(1).item
    end
  end

  context "#kills" do
    it "should have multiple elements" do
      eve_api.map.kills.should have_at_least(1).item
    end
  end

  context "#jumps" do
    it "should have multiple elements" do
      eve_api.map.jumps.should have_at_least(1).item
    end
  end

  context "#fac_war_systems" do
    it "should have multiple elements" do
      eve_api.map.fac_war_systems.should have_at_least(1).item
    end
  end
end
