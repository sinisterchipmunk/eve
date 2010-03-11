require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#alliance_list" do
    @expected_columns = "name,shortName,allianceID,executorCorpID,memberCount,startDate".split(/,/)
    
    before(:each) { @result = mock_service(:eve, :alliance_list) }
    it_should_behave_like "any Rowset"

    it "creates a list of alliances" do
      @result.should respond_to(:alliances)
    end

    it "lists member corporations in each alliance" do
      @result.alliances.each do |alliance|
        alliance.should respond_to(:member_corporations)
      end
    end

    # FIXME: Find a better, more reusable way to express this.
    context "#alliances.first" do
      @expected_columns = "corporationID,startDate".split(/,/)
      before(:each) { @rowset ||= @result; @result = @rowset.alliances.first }
      it_should_behave_like "any Rowset"
    end
  end
end
