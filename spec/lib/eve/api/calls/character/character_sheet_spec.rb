require 'spec_helper'

describe Eve::API::Services::Character do
  context "#character_sheet" do
    context "with a valid api key" do
      subject { mock_service('character', 'character_sheet', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should produce character sheet info" do
        subject.character_id.should == 150337897
        subject.name.should == "corpslave"
        subject.race.should == "Minmatar"
        subject.blood_line.should == "Brutor"
        subject.gender.should == "Female"
        subject.corporation_name.should == "corpexport Corp"
        subject.corporation_id.should == 150337746
        subject.clone_name.should == "Clone Grade Pi"
        subject.clone_skill_points.should == 54600000
        subject.balance.should == 190210393.87
        subject.attribute_enhancers.intelligence_bonus.augmentator_name.should == "Snake Delta"
        subject.attribute_enhancers.intelligence_bonus.augmentator_value.should == 3
        subject.attribute_enhancers.memory_bonus.augmentator_name.should == "Memory Augmentation - Basic"
        subject.attribute_enhancers.memory_bonus.augmentator_value.should == 3
        subject.attributes.intelligence.should == 6
        subject.attributes.memory.should       == 4
        subject.attributes.charisma.should     == 7
        subject.attributes.perception.should   == 12
        subject.attributes.willpower.should    == 10
        subject.skills.should behave_like_rowset('typeID,skillpoints,level,unpublished') { |row|
          row.should respond_to(:type_id)
          row.should respond_to(:skillpoints)
          row.should respond_to(:level)
          row.should respond_to(:unpublished)
        }
        subject.certificates.should behave_like_rowset('certificateID')
        subject.corporation_roles.should behave_like_rowset('roleID,roleName')
        subject.corporation_roles_at_hq.should behave_like_rowset('roleID,roleName')
        subject.corporation_roles_at_base.should behave_like_rowset('roleID,roleName')
        subject.corporation_roles_at_other.should behave_like_rowset('roleID,roleName')
        subject.corporation_titles.should behave_like_rowset('titleID,titleName')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'character_sheet') }.should raise_error(ArgumentError)
      end
    end
  end
end
