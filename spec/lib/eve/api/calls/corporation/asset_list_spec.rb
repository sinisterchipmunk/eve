require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#asset_list" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'asset_list', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of assets" do
        subject.assets.should behave_like_rowset('itemID,locationID,typeID,quantity,flag,singleton') { |asset|
          if asset.respond_to?(:contents)
            asset.contents.should behave_like_rowset('itemID,typeID,quantity,flag,singleton')
          end
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'asset_list') }.should raise_error(ArgumentError)
      end
    end
  end
end
