require 'spec_helper'

describe Eve::API::Services::Character do
  context "#medals" do
    context "with a valid api key" do
      subject { mock_service('character', 'medals', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $limited_api_key) }

      it "should produce medals rowset for character" do
        subject.current_corporation.should behave_like_rowset('medalID,reason,status,issuerID,issued')
        subject.other_corporations.should behave_like_rowset(
                'medalID,reason,status,issuerID,issued,corporationID,title,description')
        subject.other_corporations[0].medal_id.should == 4106
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'medals') }.should raise_error(ArgumentError)
      end
    end
  end
end
