require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#certificate_tree" do
    subject { mock_service(:eve, :certificate_tree).categories }

    it "follows expected structure" do
      subject.should behave_like_rowset('categoryID,categoryName') { |category|
        category.classes.should behave_like_rowset('classID,className') { |klass|
          klass.certificates.should behave_like_rowset('certificateID,grade,corporationID,description') { |cert|
            cert.required_skills.should behave_like_rowset('typeID,skillLevel')
            cert.required_certificates.should behave_like_rowset('certificateID,grade')
          }
        }
      }
    end
  end
end
