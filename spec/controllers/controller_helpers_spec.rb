require 'spec_helper'

# TrustController is our test controller. It defines a single #index action.
describe TrustController do
#  response do
#    
##    response = ActionDispatch::TestRequest.new(@rack_env)
#    response = TrustController.call(@rack_env.merge('action_dispatch.request.path_parameters' => {
#              :action => 'index'
#            }))
#    p response[2]
#    if response[0] != 200
#    #if exception = response.template.instance_variable_get("@exception")
#      raise response[2].body
#    end
#    #response[2]
#    response[2].request.env['action_controller.instance']
#  end

  it "should not consider the helper methods to be actions" do
    TrustController.action_methods.sort.should == %w(index)
  end

  context "from the IGB" do
    before do
      request.env['HTTP_USER_AGENT'] = 'eve-minibrowser'
      get :index
    end

#    before :all do
#      @rack_env = Rack::MockRequest.env_for("/").merge('HTTP_USER_AGENT' => 'eve-minibrowser')
#    end
                          
    context "without trust" do
      it "should require trust" do
        response.headers['eve.trustme'].should_not be_blank
      end
    end

    context "with trust" do

    end

    context "and an IGB template exists" do
#      before(:all) { @rack_env.merge!('mock_methods' => { :default_template_exists? => true }) }
      it "responds with an IGB-specific page" do
        response.formats.should include(:igb)
      end
    end

    context "and an IGB template does not exist" do
#      before(:all) { @rack_env.merge!('mock_methods' => { :default_template_exists? => false }) }
      it "does not respond with an IGB-specific page" do
        response.formats.should_not include(:igb)
      end
    end
  end

  context "from any other browser" do
#    before :all do
#      @rack_env = Rack::MockRequest.env_for("/").merge('HTTP_USER_AGENT' => 'Mozilla/5.001 (windows; U; NT4.0; en-US; rv:1.0) Gecko/25250101')
#    end

    it "should not require trust" do
      response.headers['eve.trustme'].should be_blank
    end

    context "and an IGB template exists" do
#      before(:all) { @rack_env.merge!('mock_methods' => { :default_template_exists? => true }) }
      it "does not respond with an IGB-specific page" do
        response.formats.should_not include(:igb)
      end
    end

    context "and an IGB template does not exist" do
      before(:each) do
#        request.env.merge!('mock_methods' => { :default_template_exists? => false })
        get :index
      end
      
      it "does not respond with an IGB-specific page" do
        p response
        response.formats.should_not include(:igb)
      end
    end
  end
end
