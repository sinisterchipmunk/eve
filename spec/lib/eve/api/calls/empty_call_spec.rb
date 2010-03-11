# I'm using this as a copy-and-paste template while I build the API specs.
=begin

require 'spec_helper'

describe Eve::API::Services::ChangeMe do
  context "#" do
    context "with a valid api key" do
      subject { mock_service('', '', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should do something" do
        subject.something.should behave_like_rowset('') { |row|
          
        }
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('', '') }.should raise_error(ArgumentError)
      end
    end
  end
end


=end