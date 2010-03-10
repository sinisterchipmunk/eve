require 'spec_helper'

describe Eve::API do
  context "#character_portrait" do
    it "should be a binary string" do
      subject.character_portrait('1234567890').should be_a(String)
    end

    it "should be cached" do
      Eve.cache.delete_matched(/.*/)
      Net::HTTP.should_receive(:post_form).once.and_return(mock_http_response('jpg/mock_portrait.jpg'))
      subject.character_portrait('1234567890')
      subject.character_portrait('1234567890')
    end
  end

  context "#server_status" do
    subject { Eve::API.new }

    it "should respond to current_time" do
      result = subject.server_status
      result.should respond_to(:current_time)
    end
    it "should respond to api_version" do
      result = subject.server_status
      result.should respond_to(:api_version)
    end
    it "should respond to server_open" do
      result = subject.server_status
      result.should respond_to(:server_open)
    end
    it "should respond to online_players" do
      result = subject.server_status
      result.should respond_to(:online_players)
    end
    it "should respond to cached_until" do
      result = subject.server_status
      result.should respond_to(:cached_until)
    end
  end
end
