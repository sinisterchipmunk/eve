require 'spec_helper'

describe Eve::Helpers::ViewHelper do
#  subject do
#    env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '', 'HTTP_USER_AGENT' => 'eve-minibrowser')
#    ActionView::Base.new([], {}, TrustController.call(env).template.controller)
#  end
  before(:each) do
    class << helper
      self.send(:include, Rails.application.routes.url_helpers)
    end
  end

  it "should delegate #igb into #controller" do
    helper.igb.should be_kind_of(Eve::Trust::IgbInterface)
  end
end
