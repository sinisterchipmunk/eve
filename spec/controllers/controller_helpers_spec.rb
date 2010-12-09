require 'spec_helper'

# TrustController is our test controller. It defines a single #index action.
describe TrustController do
  render_views
  
  it "should not consider the helper methods to be actions" do
    TrustController.action_methods.sort.should == %w(index)
  end

  context "from the IGB" do
    before do
      request.user_agent = "eve-minibrowser"
      get :index
    end

    context "without trust" do
      it "should require trust" do
        response.headers['Eve.trustme'].should_not be_blank
      end
    end

    context "with trust" do

    end

    context "and an IGB template exists" do
      before(:each) { request.headers.merge!('mock_methods' => { :default_template_exists? => true }) }
      it "responds with an IGB-specific page" do
        controller.formats.should include(:igb)
      end
    end

    context "and an IGB template does not exist" do
      before(:each) { request.headers.merge!('mock_methods' => { :default_template_exists? => false }) }
      it "does not respond with an IGB-specific page" do
        controller.formats.should_not include(:igb)
      end
    end
  end

  context "from any other browser" do
    before :each do
      request.user_agent = 'Mozilla/5.001 (windows; U; NT4.0; en-US; rv:1.0) Gecko/25250101'
    end

    it "should not require trust" do
      response.headers['Eve.trustme'].should be_blank
    end

    context "and an IGB template exists" do
      before(:each) { request.headers.merge!('mock_methods' => { :default_template_exists? => true }) }
      it "does not respond with an IGB-specific page" do
        controller.formats.should_not include(:igb)
      end
    end

    context "and an IGB template does not exist" do
      before(:each) do
        request.headers.merge!('mock_methods' => { :default_template_exists? => false })
        get :index
      end
      
      it "does not respond with an IGB-specific page" do
        controller.formats.should_not include(:igb)
      end
    end
  end
end
