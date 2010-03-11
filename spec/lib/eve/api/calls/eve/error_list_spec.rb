require 'spec_helper'

describe Eve::API::Services::Eve do
  context "#error_list" do
    subject { mock_service(:eve, :error_list).errors }

    it "follows expected structure" do
      subject.should behave_like_rowset("errorCode,errorText")
    end

    it "maps every known error to Eve::Errors::API_ERROR_MAP" do
      subject.each do |error|
        error_klass = Eve::Errors.find_by_code(error.error_code)
        error_klass.should_not == Eve::Errors::UnknownError
        proc {
          Eve::Errors.raise(:code => error.error_code, :message => error.error_text)
        }.should raise_error(error_klass)
      end
    end
  end
end
