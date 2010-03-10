require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#alliance_list" do
    before(:each) { mock_service(:eve, :alliance_list); @result = eve_api.eve.alliance_list }

    it "creates a list of alliances" do
      @result.should respond_to(:alliances)
    end

    it "lists member corporations in each alliance" do
      @result.alliances.each do |alliance|
        alliance.should respond_to(:member_corporations)
      end
    end

    it "should have 2 rows" do
      @result.should have(2).items
    end

    it "should have 2 sub-items in the first row" do
      @result[0].should have(2).items
    end

    it "should have 1 sub-item in the second row" do
      #@alliance_list.alliances[1].should respond_to(:member_corporations)
      @result[1].should have(1).item
    end
  end
end
