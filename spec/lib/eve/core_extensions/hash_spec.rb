require 'spec_helper'

describe Hash do
  it "#without" do
    { :a => 1, :b => 2, :c => 3 }.without(:a, :b).should == {:c => 3}
  end

  it "#without_values" do
    { :a => 1, :b => 1, :c => 2, :d => 2}.without_values(1).should == {:c => 2, :d => 2}
  end

  it "#optionalize" do
    { :a => nil, :b => nil, :c => 1, :d => 2 }.optionalize.should == { :c => 1, :d => 2}
  end

  it "#camelize_keys" do
    { :hello_world => 1, :goodbye_john => 2}.camelize_keys.should == { 'HelloWorld' => 1, 'GoodbyeJohn' => 2 }
  end

  it "#rename" do
    { :a => 1, :b => 2 }.rename(:a => :b, :b => :c).should == { :b => 1, :c => 2 }
  end
end
