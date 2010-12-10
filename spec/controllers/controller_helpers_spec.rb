require 'spec_helper'

# TrustController is our test controller. It defines a single #index action.
describe TrustController do
  render_views
  
  it "should not consider the helper methods to be actions" do
    TrustController.action_methods.sort.should == %w(html_and_igb html_only igb_only index no_templates)
  end

  context "from the IGB" do
    before do
      request.user_agent = "eve-minibrowser"
    end

    context "without trust" do
      it "should require trust" do
        get :index
        response.headers['Eve.trustme'].should_not be_blank
      end
    end

    context "with trust" do
      # um, we've already established trust: is there anything else in the controller that needs testing?
    end

    context "and only an IGB template exists" do
      it "responds with an IGB-specific page" do
        get :igb_only
        response.body.should == "IGB Only"
      end
    end
    
    context "and IGB and HTML templates exist" do
      it "responds with an IGB page" do
        get :html_and_igb
        response.body.should == "HTML and IGB (IGB)"
      end
    end

    context "and only an HTML template exists" do
      it "does not respond with an IGB-specific page" do
        get :html_only
        response.body.should == "HTML Only"
      end
    end
    
    context "and no templates exist" do
      it "raises a template error" do
        proc { get :no_templates }.should raise_error(ActionView::MissingTemplate)
      end
    end
  end

  context "from any other browser" do
    before :each do
      request.user_agent = 'Mozilla/5.001 (windows; U; NT4.0; en-US; rv:1.0) Gecko/25250101'
    end

    it "should not require trust" do
      get :index
      response.headers['Eve.trustme'].should be_blank
    end

    context "and only an IGB template exists" do
      it "raises a template error" do
        proc { get :igb_only }.should raise_error(ActionView::MissingTemplate)
      end
    end
    
    context "and IGB and HTML templates exist" do
      it "responds with an IGB page" do
        get :html_and_igb
        response.body.should == "HTML and IGB (HTML)"
      end
    end

    context "and only an HTML template exists" do
      it "does not respond with an IGB-specific page" do
        get :html_only
        response.body.should == "HTML Only"
      end
    end
    
    context "and no templates exist" do
      it "raises a template error" do
        proc { get :no_templates }.should raise_error(ActionView::MissingTemplate)
      end
    end
  end
end
