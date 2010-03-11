require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#ref_types" do
    subject { mock_service(:eve, :ref_types) }

    it "produces a hash with 96 entries" do
      subject.should have(96).entries
    end
  end
end
