require 'spec_helper'

describe Eve::API do
  context "#server_status" do
    before(:each) { @result = mock_service('server', 'server_status').server_status }
    subject { Eve::API.new }

    it "should respond to current_time" do
      @result.should respond_to(:current_time)
    end
    it "should respond to api_version" do
      @result.should respond_to(:api_version)
    end
    it "should respond to server_open" do
      @result.should respond_to(:server_open)
    end
    it "should respond to online_players" do
      @result.should respond_to(:online_players)
    end
    it "should respond to cached_until" do
      @result.should respond_to(:cached_until)
    end
  end
end
