require 'spec_helper'

describe Eve::Helpers::ViewHelper do
  subject do
    env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '', 'HTTP_USER_AGENT' => 'eve-minibrowser')
    ActionView::Base.new([], {}, TrustController.call(env).template.controller)
  end

  it "should delegate #igb into #controller" do
    subject.igb.should be_kind_of(Eve::Trust::IgbInterface)
  end
end
