require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#standings" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'standings', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of standings" do
        subject.corporation_standings.standings_to.characters.should behave_like_rowset('toID,toName,standing')
        subject.corporation_standings.standings_to.corporations.should behave_like_rowset('toID,toName,standing')
        subject.corporation_standings.standings_to.alliances.should behave_like_rowset('toID,toName,standing')

        subject.corporation_standings.standings_from.agents.should behave_like_rowset('fromID,fromName,standing')
        subject.corporation_standings.standings_from.npc_corporations.should behave_like_rowset('fromID,fromName,standing')
        subject.corporation_standings.standings_from.factions.should behave_like_rowset('fromID,fromName,standing')

        subject.alliance_standings.standings_to.corporations.should behave_like_rowset('toID,toName,standing')
        subject.alliance_standings.standings_to.alliances.should behave_like_rowset('toID,toName,standing')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'standings') }.should raise_error(ArgumentError)
      end
    end
  end
end
