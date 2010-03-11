require 'spec_helper'

describe Eve::API::Services::Character do
  context "#skill_in_training" do
    context "with a valid api key" do
      context "with a character that is training" do
        subject { mock_service('xml/character/skill_in_training.xml', :user_id => $user_id,
                                                       :character_id => $character_id,
                                                       :api_key => $limited_api_key).character.skill_in_training }


        it "should return skill training information" do
          subject.current_tq_time.should == Time.parse('2008-08-17 06:43:00 +0000')
          subject.training_end_time.should == Time.parse('2008-08-17 15:29:44 +0000')
          subject.training_start_time.should == Time.parse('2008-08-15 04:01:16 +0000')
          subject.training_type_id.should == 3305
          subject.training_start_sp.should == 24000
          subject.training_destination_sp.should == 135765
          subject.training_to_level.should == 4
          subject.skill_in_training.should == 1
        end
      end

      context "with a character that is not training" do
        subject { mock_service('xml/character/skill_not_in_training.xml', :user_id => $user_id,
                                                       :character_id => $character_id,
                                                       :api_key => $full_api_key).character.skill_in_training }


        it "should produce a result with #skill_in_training == 0" do
          subject.skill_in_training.should == 0
        end
      end
    end

    context "without an api key" do
      subject { mock_service('xml/character/skill_in_training.xml', {}) }
      
      it "should raise an ArgumentError" do
        proc { subject.character.skill_in_training }.should raise_error(ArgumentError)
      end
    end
  end
end
