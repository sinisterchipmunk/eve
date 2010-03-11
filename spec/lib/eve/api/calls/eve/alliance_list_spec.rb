require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#alliance_list" do
    subject { mock_service(:eve, :alliance_list) }

    context "#alliances" do
      subject { mock_service(:eve, :alliance_list).alliances }
      it "should behave like a Rowset" do
        subject.should behave_like_rowset("name,shortName,allianceID,executorCorpID,memberCount,startDate") { |alliance|
          alliance.member_corporations.should behave_like_rowset('corporationID,startDate')
        }
      end
    end

    it "creates a list of alliances" do
      subject.should respond_to(:alliances)
    end

    it "lists member corporations in each alliance" do
      subject.alliances.each do |alliance|
        alliance.should respond_to(:member_corporations)
      end
    end
  end
end
