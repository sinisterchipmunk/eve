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
  end
end
