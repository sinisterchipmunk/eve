require 'spec_helper'

shared_examples_for "any Rowset" do
  # We could just query @result for the list of columns, but that would defeat the purpose of the test because
  # we wouldn't know if rowset.columns is actually what the test was expecting.

  unless @expected_columns.kind_of?(Array)
    raise ArgumentError, "Expected @expected_columns to be an array (make sure it_should_behave_like 'Any Rowset' "+
            "comes AFTER @expected_columns is assigned)"
  end

  @expected_columns.collect { |c| (c.kind_of?(String) ? c : c.to_s).underscore }.each do |expected|
    expected = expected.is_a?(String) ? expected : expected.to_s
    expected = expected.underscore
    it "populates each row in the RowSet with the :#{expected} column" do
      @result.rowset.each do |row|
        row.should respond_to(expected)
      end
    end
  end

  @expected_columns.collect { |c| (c.kind_of?(String) ? c : c.to_s).underscore }.each do |expected|
    expected = expected.is_a?(String) ? expected : expected.to_s
    it "populates each row in the RowSet with the :#{expected} column" do
      @result.rowset.each do |row|
        row.should respond_to(expected)
      end
    end
  end
end
