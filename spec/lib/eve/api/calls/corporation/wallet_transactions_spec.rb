require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#wallet_transactions" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'wallet_transactions', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of wallet transactions" do
        subject.transactions.should behave_like_rowset('transactionDateTime,transactionID,quantity,typeName,typeID,
            price,clientID,clientName,characterID,characterName,stationID,stationName,transactionType,transactionFor')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'wallet_transactions') }.should raise_error(ArgumentError)
      end
    end
  end
end
