require 'spec_helper'

describe Eve::API::Services::Character do
  context "#wallet_transactions" do
    context "with a valid api key" do
      subject { mock_service('character', 'wallet_transactions', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide a list of wallet transaction entries" do
        subject.transactions.should behave_like_rowset('transactionDateTime,transactionID,quantity,typeName,typeID,price,clientID,clientName,stationID,stationName,transactionType,transactionFor')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'wallet_transactions') }.should raise_error(ArgumentError)
      end
    end
  end
end
