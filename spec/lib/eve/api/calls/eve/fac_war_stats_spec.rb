require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#fac_war_stats" do
    subject { mock_service(:eve, :fac_war_stats) }

    context "#totals" do
      subject { mock_service(:eve, :fac_war_stats).totals }
      it "should list yesterday's kills" do subject.kills_yesterday.should == 677 end
      it "should list last week's kills" do subject.kills_last_week.should == 3246 end
      it "should list total kills" do subject.kills_total.should == 232772 end
      it "should list yesterday's victory points" do subject.victory_points_yesterday.should == 55087 end
      it "should list last week's victory points" do subject.victory_points_last_week.should == 414049 end
      it "should list total victory points" do subject.victory_points_total.should == 44045189 end
    end
    
    it "produces a #factions rowset" do
      subject.factions.should behave_like_rowset("factionID,factionName,pilots,systemsControlled,killsYesterday,killsLastWeek,killsTotal,victoryPointsYesterday,victoryPointsLastWeek,victoryPointsTotal")
    end

    it "produces a #faction_wars rowset" do
      subject.faction_wars.should behave_like_rowset("factionID,factionName,againstID,againstName")
    end
  end
end
