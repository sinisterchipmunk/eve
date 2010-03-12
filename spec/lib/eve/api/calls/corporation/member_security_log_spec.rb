require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#member_security_log" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'member_security_log', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load lists of role changes for members in corporation" do
        subject.role_history.should behave_like_rowset('changeTime,characterID,issuerID,roleLocationType') { |history|
          history.old_roles.should behave_like_rowset('roleID,roleName')
          history.new_roles.should behave_like_rowset('roleID,roleName')
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'member_security_log') }.should raise_error(ArgumentError)
      end
    end
  end
end
