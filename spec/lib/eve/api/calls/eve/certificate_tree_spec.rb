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
=begin
    <rowset name="categories" key="categoryID" columns="categoryID,categoryName">
      <row categoryID="3" categoryName="Core">
        <rowset name="classes" key="classID" columns="classID,className">
          <row classID="2" className="Core Fitting">
            <rowset name="certificates" key="certificateID" columns="certificateID,grade,corporationID,description">
              <row certificateID="5" grade="1" corporationID="1000125" description="This certificate represents a basic level of competence in fitting ships. It certifies that the holder is able to use baseline modules which improve power and CPU capabilities such as Co-Processors, Power Diagnostic Systems and Reactor Control Units. This is the first step towards broadening your fitting options.">
                <rowset name="requiredSkills" key="typeID" columns="typeID,skillLevel">
                  <row typeID="3413" level="3"/>
=end
    #behaves_like_rowset "categories", "categoryID,categoryName" do
    #  behaves_like_rowset "classes", "classID,className" do
    #    behaves_like_rowset 'certificates', "certificateID,grade,corporationID,description"
    #  end
    #end
  end
end
