require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#alliance_list" do
    it "should load" do
      mock_service(:eve, :alliance_list)
      eve_api.eve.alliance_list.should_not be_nil
    end
  end
end
