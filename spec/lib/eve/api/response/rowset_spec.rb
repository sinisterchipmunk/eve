require 'spec_helper'

describe Eve::API::Response::Rowset do
  context "with mismatched attributes" do
    subject do
      Eve::API::Response::Rowset.new(Hpricot::XML(mock_response_body('xml/rowset_with_mismatched_attributes.xml')).root)
    end

    it "should do stuff" do
      proc { subject }.should raise_error(Eve::Errors::InvalidRowset)
    end
  end

  context "with a sovereignty map" do
    subject do
      Eve::API::Response::Rowset.new((Hpricot::XML(mock_response_body('map', 'sovereignty')).root / "rowset").first)
    end

    it "should define row attributes as methods" do
      subject[0].should respond_to(:solar_system_id)
    end
  end
end
