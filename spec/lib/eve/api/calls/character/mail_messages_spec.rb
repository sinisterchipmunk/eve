require 'spec_helper'

describe Eve::API::Services::Character do
  context "#mail_messages" do
    context "with a valid api key" do
      subject { mock_service('character', 'mail_messages', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide a list of mail messages" do
        subject.mail_messages.should behave_like_rowset('messageID,senderID,sentDate,title,toCorpOrAllianceID,toCharacterIDs,toListIDs,read')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'mail_messages') }.should raise_error(ArgumentError)
      end
    end
  end
end
