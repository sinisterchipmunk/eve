require 'spec_helper'

describe Eve::API::Services::Corporation do
  context "#titles" do
    context "with a valid api key" do
      subject { mock_service('corporation', 'titles', :user_id => $user_id,
                                                     :character_id => $character_id,
                                                     :api_key => $full_api_key) }

      it "should load a list of titles and associated roles" do
        subject.titles.should behave_like_rowset('titleID,titleName') { |title|
          %w(roles grantable_roles roles_at_hq grantable_roles_at_hq roles_at_base grantable_roles_at_base
             roles_at_other grantable_roles_at_other).each do |role|
            title.send(role).should behave_like_rowset('roleID,roleName')
          end
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('corporation', 'titles') }.should raise_error(ArgumentError)
      end
    end
  end
end
