class Eve::API::Response::Row
  include Eve::API::Response::Result
  attr_reader :fields
  attr_reader :rowsets

  def initialize(row, columns = row.attribute_nodes.collect { |c| c.name })
    @rowsets = []

    # @fields = row.attributes.keys.collect { |f| f.underscore }
    @fields = columns.collect { |c| c.underscore }

    # pre-emptively define all known columns to return nil
    klass = (class << self; self; end)
    columns.each { |c| klass.send(:define_method, c.underscore) { nil } }

    row.attribute_nodes.each_with_index do |attr, i|
      name = columns[i]
      if name.nil?
        name = attr.name
        @fields << name.underscore
      end
      value = literal_value_for attr.value

      klass.module_eval do
        define_method name.underscore do
          value
        end

        alias_method name, name.underscore
      end
    end

    parse_children row
  end

  def inspect
    "<Row " +
    fields.map do |field_name|
      "#{field_name}: #{send field_name}"
    end.join(', ') + ">"
  end
end
