require 'spec_helper'

describe Eve::API::Response do
  context "server_status" do
    subject do
      Eve::API::Response.new(mock_request(:server, :server_status))
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
end
