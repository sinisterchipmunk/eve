require 'spec_helper'

describe Eve::API::Services::Character do
  context "#industry_jobs" do
    context "with a valid api key" do
      subject { mock_service('character', 'industry_jobs', :user_id => '01234567890',
                                                     :character_id => '1234567890',
                                                     :api_key => 'a_valid_api_key') }

      it "should provide an industry jobs list" do
        subject.jobs.should behave_like_rowset('jobID,assemblyLineID,containerID,installedItemID,
            installedItemLocationID,installedItemQuantity,installedItemProductivityLevel,installedItemMaterialLevel,
            installedItemLicensedProductionRunsRemaining,outputLocationID,installerID,runs,licensedProductionRuns,
            installedInSolarSystemID,containerLocationID,materialMultiplier,charMaterialMultiplier,timeMultiplier,
            charTimeMultiplier,installedItemTypeID,outputTypeID,containerTypeID,installedItemCopy,completed,
            completedSuccessfully,installedItemFlag,outputFlag,activityID,completedStatus,installTime,
            beginProductionTime,endProductionTime,pauseProductionTime')
      end
    end

    context "without an api key" do
      it "should raise an ArgumentError" do
        proc { mock_service('character', 'industry_jobs') }.should raise_error(ArgumentError)
      end
    end
  end
end
