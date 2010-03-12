require 'spec_helper'

describe Eve::API::Response do
  context "server_status" do
    subject do
      Eve::API::Response.new(mock_http_response(:server, :server_status).body)
    end

    it "should respond_to :api_version" do
      should respond_to(:api_version)
    end
    
    it "should respond_to :current_time" do
      should respond_to(:current_time)
    end

    it "should respond_to :server_open" do
      should respond_to(:server_open)
    end

    it "should respond_to :online_players" do
      should respond_to(:online_players)
    end

    it "should respond_to :cached_until" do
      should respond_to(:cached_until)
    end

    it "should provide access to attributes via [] operator" do
      subject[:api_version].should_not be_nil
    end

    it "should provide access to attributes via [] operator" do
      subject[:apiVersion].should_not be_nil
    end

    it "should provide access to attributes via [] operator" do
      subject[:online_players].should_not be_nil
    end

    it "should provide access to attributes via [] operator" do
      subject[:onlinePlayers].should_not be_nil
    end
  end

  context "with a rowset" do
    subject do
      Eve::API::Response.new(mock_http_response(:map, :sovereignty).body)
    end

    it "delegates the name of the rowset into the rowset from the response object" do
      subject.should respond_to(:solar_systems)
    end

    it "defines rowset attributes: #name" do
      subject.solar_systems.name.should == 'solarSystems'
    end

    it "defines rowset attributes: #key" do
      subject.solar_systems.key.should == 'solarSystemID'
    end

    it "defines rowset attributes: #columns" do
      subject.solar_systems.columns.should == %w(solarSystemID allianceID factionID solarSystemName corporationID)
    end
  end
end
