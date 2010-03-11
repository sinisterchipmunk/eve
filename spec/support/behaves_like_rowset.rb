module BehavesLikeRowset
  def behaves_like_rowset(name, with_fields, options = {}, &block)
    with_fields = with_fields.split(/,/) unless with_fields.kind_of?(Array)
    child = options[:containing]
    child_descr = child ? ", containing #{child.to_s.pluralize}" : ""
    context "behaves like #{name}, which is a Rowset with fields #{with_fields.inspect}#{child_descr}" do
      @expected_columns = with_fields
      before(:each) { @parent = @result; @result = @parent.send(name).first }
      it_should_behave_like "any Rowset"

      if block_given?
        context 'which' do
          instance_eval &block
        end
      end
    end
  end
end

Spec::Runner.configure do |config|
  config.extend(BehavesLikeRowset)
end
