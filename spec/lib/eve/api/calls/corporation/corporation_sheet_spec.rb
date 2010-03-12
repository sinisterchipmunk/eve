require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#corporation_sheet" do
    context "with a valid api key" do
      subject {
        mock_service('xml/corporation/member_corporation_sheet.xml', :user_id => $user_id,
                                                                     :character_id => $character_id,
                                                                     :api_key => $limited_api_key
        ).corporation.corporation_sheet
      }

      it "should load a corporation sheet with wallet and division information" do
        subject.corporation_id.should == 150212025
        subject.corporation_name.should == "Banana Republic"
        subject.ticker.should == "BR"
        subject.divisions.should have(7).elements
        subject.wallet_divisions.should have(7).elements
        subject.logo.should_not be_nil
      end
    end

    context "without an api key" do
      subject { mock_service('xml/corporation/non_member_corporation_sheet.xml').corporation.corporation_sheet }

      it "should load a corporation sheet without wallet or division information" do
        subject.corporation_id.should == 150333466
        subject.corporation_name.should == "Marcus Corp"
        subject.ticker.should == "MATT2"
        subject.should_not respond_to(:divisions)
        subject.should_not respond_to(:wallet_divisions)
        subject.logo.should_not be_nil
      end
    end
  end
end
