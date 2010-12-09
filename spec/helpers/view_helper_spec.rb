require 'spec_helper'

describe Eve do
  it "should delegate #igb into #controller" do
    helper.igb.should be_kind_of(Eve::Trust::IgbInterface)
  end
end
