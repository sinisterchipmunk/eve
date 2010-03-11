require 'spec_helper'

describe Eve::API::Services::Character do
  context "#market_orders" do
    context "with a valid api key" do
      subject { mock_service('character', 'market_orders', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide a list of market orders" do
        subject.orders.should behave_like_rowset('orderID,charID,stationID,volEntered,volRemaining,minVolume,orderState,typeID,range,accountKey,duration,escrow,price,bid,issued')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'market_orders') }.should raise_error(ArgumentError)
      end
    end
  end
end
