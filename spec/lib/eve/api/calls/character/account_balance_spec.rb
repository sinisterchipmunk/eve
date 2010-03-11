require 'spec_helper'

describe Eve::API::Services::Character do
  context "#account_balance" do
    context "with a valid api key" do
      subject { mock_service('character', 'account_balance', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide account balance information" do
        subject.accounts.should behave_like_rowset('accountID,accountKey,balance')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'account_balance') }.should raise_error(ArgumentError)
      end
    end
  end
end
