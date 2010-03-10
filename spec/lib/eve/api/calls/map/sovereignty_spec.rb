require 'spec_helper'

describe Eve::API::Services::Map do
  context "#sovereignty" do
    before(:each) { mock_service('map', 'sovereignty'); @result = eve_api.map.sovereignty }

    it "creates a RowSet called :solar_systems" do
      @result.should respond_to(:solar_systems)
    end

    it "produces 10 rows in the RowSet" do
      @result.solar_systems.should have(10).systems
    end

    it "populates each row in the RowSet with all relevant columns" do
      @result.solar_systems.each do |system|
        for column in @result.solar_systems.columns
          system.should respond_to(column)
        end
      end
    end

    it "populates each row in the RowSet with all relevant columns, underscored" do
      @result.solar_systems.each do |system|
        for column in @result.solar_systems.columns
          system.should respond_to(column.underscore)
        end
      end
    end
  end
end
