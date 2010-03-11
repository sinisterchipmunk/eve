require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#skill_tree" do
    subject { mock_service(:eve, :skill_tree).skill_groups }

    it "contains rows of skills" do
      subject.should behave_like_rowset('groupName,groupID') do |group|
        group.skills.should behave_like_rowset('typeName,groupID,typeID') do |skill|
          for field in %w(description rank required_skills required_attributes skill_bonus_collection)
            skill.should respond_to(field)
          end
        end
      end
    end
  end
end
