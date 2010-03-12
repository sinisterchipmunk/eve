require 'spec_helper'

describe Eve::Trust::ControllerHelpers do
  subject do
    subject = TrustController.call(@rack_env)
    if exception = subject.template.instance_variable_get("@exception")
      raise exception
    end
    subject
  end

  it "should not consider the helper methods to be actions" do
    TrustController.action_methods.sort.should == %w()
  end

  context "from the IGB" do
    before :all do
      @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '', 'HTTP_USER_AGENT' => 'eve-minibrowser')
    end

    context "without trust" do
      it "should require trust" do
        subject.headers['eve.trustme'].should_not be_blank
      end
    end

    context "with trust" do

    end

    context "and an IGB template exists" do
      before(:all) { @rack_env.merge!('mock_methods' => { :default_template_exists? => true }) }
      it "responds with an IGB-specific page" do
        subject.template.template_format.should == :igb
      end
    end

    context "and an IGB template does not exist" do
      before(:all) { @rack_env.merge!('mock_methods' => { :default_template_exists? => false }) }
      it "responds with an IGB-specific page" do
        subject.template.template_format.should_not == :igb
      end
    end
  end
end
