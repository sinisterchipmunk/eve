require 'spec_helper'

describe Eve::API::Response do
  context "server_status" do
    subject do
      Eve::API::Response.new(mock_http_response(:server, :server_status).body)
    end

    it "should be convertible to Hash" do
      subject.to_hash.should == {"current_time"=>DateTime.parse("Wed, 10 Mar 2010 01:03:36 +0000"),
                                 "cached_until"=>DateTime.parse("Sat, 10 Mar 2040 01:06:36 +0000"),
                                 "online_players"=>31835,
                                 "server_open"=>true,
                                 "api_version"=>"2"}
    end

    it "should be convertible to YAML" do
      subject.to_yaml.should == subject.to_hash.to_yaml
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
