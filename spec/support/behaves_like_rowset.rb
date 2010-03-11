class BehavesLikeRowset
  attr_reader :failure_message, :negative_failure_message
  
  def initialize(columns, &block)
    @expected_columns = (columns.kind_of?(Array) ? columns : columns.split(/,/)).collect { |c| c.strip }
    @block = block if block_given?
    @missing = []
  end

  def matches?(target)
    @target = target
    check_for_column_mismatches

    @target.each_with_index do |row, index|
      @expected_columns.each do |column|
        check_column(row, column)
      end
      return false if !check_for_missing(index)
      @block.call(row) if @block
    end
    true
  end

  private
  def check_for_missing(id)
    if !@missing.empty?
      @failure_message = "expected row #{id} in #{@target.inspect} to respond_to each of #{@missing.inspect}"
      @negative_failure_message = "expected row in #{@target.inspect} not to respond_to each of #{@missing.inspect}"
      return false
    end
    true
  end

  def check_for_column_mismatches
    @target.columns.should == @expected_columns
  end

  def check_column(row, column)
    check_for_response(row, column)
    check_for_response(row, column.underscore)
  end

  def check_for_response(row, method_name)
    @missing << method_name if !row.respond_to?(method_name)
  end
end

def behave_like_rowset(expected_columns, &block)
  BehavesLikeRowset.new(expected_columns, &block)
end
