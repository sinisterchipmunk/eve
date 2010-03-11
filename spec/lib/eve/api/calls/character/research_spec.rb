require 'spec_helper'

describe Eve::API::Services::Character do
  context "#research" do
    context "with a valid api key" do
      subject { mock_service('character', 'research', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should provide a list of research jobs" do
        subject.research.should behave_like_rowset('agentID,skillTypeID,researchStartDate,pointsPerDay,remainderPoints')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'research') }.should raise_error(ArgumentError)
      end
    end
  end
end
