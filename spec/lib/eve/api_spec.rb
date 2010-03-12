require 'spec_helper'

describe Eve::API do
  it "should update options with #set, given 2 arguments" do
    subject.set(:api_key, $limited_api_key)
    subject[:api_key].should == $limited_api_key
  end

  it "should update options with #set, given a hash" do
    subject.set(:api_key => $full_api_key)
    subject[:api_key].should == $full_api_key
  end
end
