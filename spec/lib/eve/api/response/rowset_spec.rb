require 'spec_helper'

describe Eve::API::Response::Rowset do
  context "with mismatched attributes" do
    subject do
      Eve::API::Response::Rowset.new(Hpricot::XML(mock_response_body('xml/rowset_with_mismatched_attributes.xml')).root)
    end

    # Note, in order to address /char/character_sheet (which provides 2 optional attributes, 'level' and 'unpublished',
    # this requirement has been removed.
    #
    # TODO: See if this is an error in the mock XML, or if these attributes are really optional.
    #
    #it "should raise an InvalidRowset error" do
    #  proc { subject }.should raise_error(Eve::Errors::InvalidRowset)
    #end
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
