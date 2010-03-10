require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#alliance_list" do
    before(:each) { mock_service(:eve, :alliance_list) }

    it "should have 2 rows" do
      eve_api.eve.alliance_list.should have(2).items
    end

    it "should have 2 sub-items in the first row" do
      eve_api.eve.alliance_list[0].should have(2).items
    end

    it "should have 1 sub-item in the second row" do
      eve_api.eve.alliance_list[1].should have(1).item
    end
  end
end
