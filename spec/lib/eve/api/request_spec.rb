require 'spec_helper'

describe Eve::API::Request do
  subject { Eve::API::Request.new('server', 'server_status') }

  it "should dispatch and return a Response" do
    response = subject.dispatch
    response.should be_a(Eve::API::Response)
  end

  it "should cache repeat requests" do
    Eve.cache.delete_matched /.*/
    Net::HTTP.should_receive(:post_form).once.and_return(mock_http_response(subject.namespace, subject.service))
    subject.dispatch
    subject.dispatch
  end
end
