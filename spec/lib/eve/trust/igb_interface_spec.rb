require 'spec_helper'

describe Eve::Trust::IgbInterface do
  @@igb_headers = {
          'HTTP_USER_AGENT' => 'eve-minibrowser',
          'HTTP_EVE_TRUSTED' => 'yes',
          'HTTP_EVE_SERVERIP' => '1.2.3.4',
          'HTTP_EVE_CHARNAME' => 'Jolia Darkstrider',
          'HTTP_EVE_CHARID' => '1234567890',
          'HTTP_EVE_CORPNAME' => 'Frogs of Armageddon',
          'HTTP_EVE_CORPID' => '9876543210',
          'HTTP_EVE_ALLIANCENAME' => 'Afro Mexicans',
          'HTTP_EVE_ALLIANCEID' => '1928374',
          'HTTP_EVE_REGIONNAME' => 'Solitude',
          'HTTP_EVE_CONSTELLATIONNAME' => 'Morbault',
          'HTTP_EVE_SOLARSYSTEMNAME' => 'Elore',
          'HTTP_EVE_STATIONNAME' => 'Caldari Navy Assembly Plant',
          'HTTP_EVE_STATIONID' => '1234',
          'HTTP_EVE_CORPROLE' => '0'
  }
  @@igb_requested_headers = {
          'HTTP_EVE_MILITIANAME' => 'militia name',
          'HTTP_EVE_MILITIAID' => '1234567',
          'HTTP_EVE_REGIONID' => '1929',
          'HTTP_EVE_CONSTELLATIONID' => '100',
          'HTTP_EVE_SOLARSYSTEMID' => '101',
          'HTTP_EVE_SHIPID' => '102',
          'HTTP_EVE_SYSTEMSECURITY' => '0.9',
          'HTTP_EVE_VALIDATION_STRING' => 'abcdefghijklmnopqrstuvwxyz'
  }

  subject { Eve::Trust::IgbInterface.new(ActionController::Request.new(@rack_env)) }

  shared_examples_for "any igb with trust" do
    it "should be trusted" do
      subject.trusted?.should be_true
    end

    it "should convert strings to objects using YAML where possible" do
      subject.char_id.should == 1234567890
      subject.corp_id.should == 9876543210
      subject.alliance_id.should == 1928374
      subject.station_id.should == 1234
      subject.corp_role.should == 0
    end

    it "should have all methods delegated properly" do
      subject.server_ip.should == '1.2.3.4'
      subject.char_name.should == 'Jolia Darkstrider'
      subject.corp_name.should == 'Frogs of Armageddon'
      subject.alliance_name.should == 'Afro Mexicans'
      subject.region_name.should == 'Solitude'
      subject.constellation_name.should == 'Morbault'
      subject.solar_system_name.should == 'Elore'
      subject.station_name.should == 'Caldari Navy Assembly Plant'
    end
  end

  context "using new igb - moondoggie" do
    before(:all) do
      @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '', 'HTTP_USER_AGENT' => 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0 EVE-IGB ')
    end

    it "should be considered an igb" do
      subject.igb?.should be_true
    end
  end

  context "without any IGB headers" do
    before(:all) do
      @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '', 'HTTP_USER_AGENT' => 'eve-minibrowser')
    end

    it("should not be trusted") { subject.trusted?.should_not be_true }
  end

  context "without trust" do
    before(:all) do
      @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '',
                                                       'HTTP_USER_AGENT' => 'eve-minibrowser',
                                                       'HTTP_EVE_TRUST' => 'no')
    end

    it("should not be trusted") { subject.trusted?.should_not be_true }
  end

  context "with trust" do
    it_should_behave_like "any igb with trust"
    before(:all) do
      @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '').merge(@@igb_headers)
    end

    context "after requests are implemented" do
      it_should_behave_like "any igb with trust"

      before(:all) do
        @rack_env = Rack::MockRequest.env_for("/").merge('REQUEST_URI' => '').merge(@@igb_headers).merge(@@igb_requested_headers)
      end

      it "should load the additional data" do
        subject.militia_name.should == 'militia name'
        subject.militia_id.should == 1234567
        subject.region_id.should == 1929
        subject.constellation_id.should == 100
        subject.solar_system_id.should == 101
        subject.ship_id.should == 102
        subject.system_security.should == 0.9
        subject.validation_string.should == 'abcdefghijklmnopqrstuvwxyz'
      end
    end
  end
end
