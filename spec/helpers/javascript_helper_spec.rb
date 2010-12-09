require 'spec_helper'

describe Eve::JavascriptHelper do
  subject { ActionView::Base.new }

  it "should link to mailing list" do
    subject.link_to_mailing_list("link", '1').should == '<a href="#" onclick="CCPEVE.joinMailingList(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to channel" do
    subject.link_to_channel("link", '1').should == '<a href="#" onclick="CCPEVE.joinChannel(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to waypoint" do
    subject.link_to_waypoint("link", '1').should == '<a href="#" onclick="CCPEVE.addWaypoint(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to destination" do
    subject.link_to_destination("link", '1').should == '<a href="#" onclick="CCPEVE.setDestination(&quot;1&quot;); return false;">link</a>'
  end

  it "should request trust" do
    subject.request_trust("link").should == "<script type=\"text/javascript\">\n//<![CDATA[\nCCPEVE.requestTrust(\"link\");\n//]]>\n</script>"
  end

  it "should link to trust request" do
    subject.link_to_trust_request("link", '1').should == '<a href="#" onclick="CCPEVE.requestTrust(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to market details" do
    subject.link_to_market_details("link", '1').should == '<a href="#" onclick="CCPEVE.showMarketDetails(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to contract" do
    subject.link_to_contract("link", '1', '2').should == '<a href="#" onclick="CCPEVE.showContract(&quot;1&quot;, &quot;2&quot;); return false;">link</a>'
  end

  it "should link to fitting" do
    subject.link_to_fitting("link", '1').should == '<a href="#" onclick="CCPEVE.showFitting(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to map" do
    subject.link_to_route("link", '1').should == '<a href="#" onclick="CCPEVE.showRouteTo(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to route" do
    subject.link_to_route("link", '1').should == '<a href="#" onclick="CCPEVE.showRouteTo(&quot;1&quot;); return false;">link</a>'
    subject.link_to_route("link", '1', '2').should == '<a href="#" onclick="CCPEVE.showRouteTo(&quot;1&quot;, &quot;2&quot;); return false;">link</a>'
  end

  it "should link to preview" do
    subject.link_to_preview("link", '1').should == '<a href="#" onclick="CCPEVE.showPreview(&quot;1&quot;); return false;">link</a>'
  end

  it "should link to showinfo" do
    subject.link_to_info("link", "typeid").should == '<a href="#" onclick="CCPEVE.showInfo(&quot;typeid&quot;); return false;">link</a>'
    subject.link_to_info("link", 1, 2).should == '<a href="#" onclick="CCPEVE.showInfo(1, 2); return false;">link</a>'
  end

  it "should link to evemail" do
    subject.link_to_evemail("link").should == '<a href="#" onclick="CCPEVE.openEveMail(); return false;">link</a>'
  end

  context '#type_id' do
    it "should raise ArgumentError if type doesn't match" do
      proc { subject.type_id('something that is completely invalid') }.should raise_error(ArgumentError)
    end

    it 'should return valid ID when given a valid argument' do
      subject.type_id('Alliance').should == 16159
      subject.type_id('Character').should == 1377
      subject.type_id(:corporation).should == 2
      subject.type_id(:constellation).should == 4
      subject.type_id(:region).should == 3
      subject.type_id(:solar_system).should == 5
      subject.type_id("Solar System").should == 5
      subject.type_id(:station).should == 3867
    end
  end
end
