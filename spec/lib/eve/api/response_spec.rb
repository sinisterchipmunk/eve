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
  end

  context "with a rowset" do
    subject do
      Eve::API::Response.new(mock_http_response(:map, :sovereignty).body)
    end

    it "defines rowset attributes on the response object: #name" do
      subject.name.should == 'solarSystems'
    end

    it "defines rowset attributes on the response object: #key" do
      subject.key.should == 'solarSystemID'
    end

    it "defines rowset attributes on the response object: #columns" do
      subject.columns.should == %w(solarSystemID allianceID factionID solarSystemName corporationID)
    end
  end
end
