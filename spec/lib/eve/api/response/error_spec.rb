require 'spec_helper'

describe Eve::API::Response do
  %w(106).each do |code|
    context "with error #{code}" do
      subject { mock_service("xml/errors/#{code}.xml", :cache => false) }
      # Eve::API::Response.new(mock_response_body("xml/errors/#{code}.xml")) }
      
      it("should raise a #{code} error") do
        proc { subject.server_status }.should raise_error(Eve::Errors::API_ERROR_MAP[code.to_i])
      end
    end
  end
end
