require 'spec_helper'

describe Eve::API::Request do
  subject { Eve::API::Request.new('server', 'server_status') }

  it "should POST and return a response" do
    response = subject.post!
    response.should be_a(String)
    puts response
  end

  it "should GET and return a response" do
    response = subject.get!
    response.should be_a(String)
    puts response
  end
end
