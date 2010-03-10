require 'spec_helper'

describe Eve::API do
  context "#character_portrait" do
    it "should be a binary string" do
      subject.character_portrait('1234567890').should be_a(String)
    end

    it "should be cached" do
      Eve.cache.delete_matched /\/serv\.asp/
      Net::HTTP.should_receive(:post_form).once.and_return(mock_http_response('jpg/mock_portrait.jpg'))
      subject.character_portrait('1234567890')
      subject.character_portrait('1234567890')
    end
  end
end
