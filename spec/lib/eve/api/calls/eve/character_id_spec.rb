require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#character_id" do
    expected_hash = { "Jolia Darkstrider"   => 661196469 ,  # characters
                      "Murdock Jern"        => 291344707 ,  # characters
                      "Frogs of Armageddon" => 1722047601,  # corporations
                      "Gears of Progress"   => 1196707484,  # corporations
                      "Band of Brothers"    => 394979878 ,  # alliances
                      "The Dead Rabbits"    => 1796285504 } # alliances

    subject do
      mock_service('xml/eve/character_id.xml')
      Eve::API.new.eve.character_id(*expected_hash.keys)
    end

    it "should return a hash" do
      subject.should be_kind_of(Hash)
    end

    expected_hash.each do |name, id|
      it "should include #{name}'s ID" do
        subject[name].should == id
      end
    end
  end
end
