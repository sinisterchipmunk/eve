require 'spec_helper'

describe Eve::API do
  context "#server_status" do
    it "should respond to current_time" do
      result = Eve::API.server_status
      result.should respond_to(:current_time)
    end
    it "should respond to api_version" do
      result = Eve::API.server_status
      result.should respond_to(:api_version)
    end
    it "should respond to server_open" do
      result = Eve::API.server_status
      result.should respond_to(:server_open)
    end
    it "should respond to online_players" do
      result = Eve::API.server_status
      result.should respond_to(:online_players)
    end
    it "should respond to cached_until" do
      result = Eve::API.server_status
      result.should respond_to(:cached_until)
    end
  end
end
