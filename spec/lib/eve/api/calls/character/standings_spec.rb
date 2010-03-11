require 'spec_helper'

describe Eve::API::Services::Character do
  context "#standings" do
    context "with a valid api key" do
      subject { mock_service('character', 'standings', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $limited_api_key) }

      it "should return the character's training queue" do
        subject.standings_to.characters.should behave_like_rowset('toID,toName,standing')
        subject.standings_to.corporations.should behave_like_rowset('toID,toName,standing')

        subject.standings_from.agents.should behave_like_rowset('fromID,fromName,standing')
        subject.standings_from.npc_corporations.should behave_like_rowset('fromID,fromName,standing')
        subject.standings_from.factions.should behave_like_rowset('fromID,fromName,standing')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'standings') }.should raise_error(ArgumentError)
      end
    end
  end
end
