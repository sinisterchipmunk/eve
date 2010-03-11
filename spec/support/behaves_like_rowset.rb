class BehavesLikeRowset
  attr_reader :failure_message, :negative_failure_message
  
  def initialize(columns, &block)
    @expected_columns = columns.kind_of?(Array) ? columns : columns.split(/,/)
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


=begin
module BehavesLikeRowset
  def behaves_like_rowset(name, with_fields, options = {}, &block)
    with_fields = with_fields.split(/,/) unless with_fields.kind_of?(Array)
    child = options[:containing]
    varname = "@#{name.underscore}"
    context "should behave like a Rowset called #{name}, with fields #{with_fields.inspect}" do
      @expected_columns = with_fields

      before(:each) do
        #@target = @result
        instance_variable_set(varname, @result || subject) unless instance_variable_get(varname)
        @result = instance_variable_get(varname).send(name).first
        puts @result.inspect
      end

      it 'test' do; end
      #it_should_behave_like "any Rowset"

      if block_given?
        context 'containing rows that' do
          instance_eval &block
        end
      end
    end
  end
end

Spec::Runner.configure do |config|
  config.extend(BehavesLikeRowset)
end
=end
