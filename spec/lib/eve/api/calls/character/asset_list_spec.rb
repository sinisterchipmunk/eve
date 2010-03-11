require 'spec_helper'

describe Eve::API::Services::Character do
  context "#asset_list" do
    context "with a valid api key" do
      subject { mock_service('character', 'asset_list', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide an asset list" do
        subject.assets.should behave_like_rowset('itemID,locationID,typeID,quantity,flag,singleton') { |asset|
          asset.contents.should behave_like_rowset('itemID,typeID,quantity,flag,singleton') if !asset.rowsets.empty?
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'asset_list') }.should raise_error(ArgumentError)
      end
    end
  end
end
