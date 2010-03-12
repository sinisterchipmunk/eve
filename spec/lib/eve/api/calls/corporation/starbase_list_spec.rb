require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#starbase_list" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'starbase_list', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of starbases" do
        subject.starbases.should behave_like_rowset('itemID,typeID,locationID,moonID,state,stateTimestamp,
            onlineTimestamp')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'starbase_list') }.should raise_error(ArgumentError)
      end
    end
  end
end
