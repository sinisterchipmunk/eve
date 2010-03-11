require 'spec_helper'

describe Eve::API::Services::Character do
  context "#kill_log" do
    context "with a valid api key" do
      subject { mock_service('character', 'kill_log', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should provide a kill list" do
        subject.kills.should behave_like_rowset('killID,solarSystemID,killTime,moonID') { |kill|
          kill.victim.character_name.should == "Dieinafire"
          
          kill.attackers.should behave_like_rowset('characterID,characterName,corporationID,corporationName,allianceID,
              allianceName,securityStatus,damageDone,finalBlow,weaponTypeID,shipTypeID')
          kill.items.should behave_like_rowset('typeID,flag,qtyDropped,qtyDestroyed')
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'kill_log') }.should raise_error(ArgumentError)
      end
    end
  end
end
