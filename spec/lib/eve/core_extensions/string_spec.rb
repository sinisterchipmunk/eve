require 'spec_helper'

describe String do
  it "#dehumanize" do
    "say_hello_to_the_world".camelize.dehumanize.should == "sayHelloToTheWorld"
    "Say hello to the world".dehumanize.should == "say_hello_to_the_world"
  end
end
