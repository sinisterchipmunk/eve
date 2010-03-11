require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#fac_war_top_stats" do
    context "#characters" do
      subject { mock_service(:eve, :fac_war_top_stats).characters }

      %w(kills_yesterday kills_last_week kills_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('characterID,characterName,kills')
        end
      end

      %w(victory_points_yesterday victory_points_last_week victory_points_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('characterID,characterName,victoryPoints')
        end
      end
    end

    context "#corporations" do
      subject { mock_service(:eve, :fac_war_top_stats).corporations }

      
      %w(kills_yesterday kills_last_week kills_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('corporationID,corporationName,kills')
        end
      end

      %w(victory_points_yesterday victory_points_last_week victory_points_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('corporationID,corporationName,victoryPoints')
        end
      end
    end

    context "#factions" do
      subject { mock_service(:eve, :fac_war_top_stats).factions }

      %w(kills_yesterday kills_last_week kills_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('factionID,factionName,kills')
        end
      end

      %w(victory_points_yesterday victory_points_last_week victory_points_total).each do |rowset|
        it "has a valid rowset called ##{rowset}" do
          subject.send(rowset).should behave_like_rowset('factionID,factionName,victoryPoints')
        end
      end
    end
  end
end
