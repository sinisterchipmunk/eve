require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#shareholders" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'shareholders', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of shareholders" do
        subject.characters.should behave_like_rowset('shareholderID,shareholderName,shareholderCorporationID,
            shareholderCorporationName,shares')
        subject.corporations.should behave_like_rowset('shareholderID,shareholderName,shares')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'shareholders') }.should raise_error(ArgumentError)
      end
    end
  end
end
