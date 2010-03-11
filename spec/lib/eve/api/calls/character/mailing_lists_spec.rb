require 'spec_helper'

describe Eve::API::Services::Character do
  context "#mailing_lists" do
    context "with a valid api key" do
      subject { mock_service('character', 'mailing_lists', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should provide a list of subscribed mailing lists" do
        subject.mailing_lists.should behave_like_rowset('listID,displayName')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'mailing_lists') }.should raise_error(ArgumentError)
      end
    end
  end
end
