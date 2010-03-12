module Eve
  class API
    class Response
      module Rowsets
        def rowset_names
          rowsets.collect { |c| c.name }
        end

        def add_rowset(rowset)
          rowsets << rowset
          rowset.delegate_from(self)
        end

        def rowsets; @rowsets ||= []; end

        def copy_attributes(columns, row_element, into = self)
          attributes = row_element.attributes.to_hash.rename((@options[:column_mapping] || {}))

          #missing_attributes = columns - attributes.keys
          #extra_attributes = attributes.keys - columns
          #raise Eve::Errors::InvalidRowset,
          #      "Missing attributes from row: #{missing_attributes.inspect}" if !missing_attributes.empty?
          #raise Eve::Errors::InvalidRowset,
          #      "Extra attributes in row: #{extra_attributes.inspect}" if !extra_attributes.empty?
          if !into.respond_to?(:wrap_object)
            klass = into.class
            klass.send(:include, WrapObject)
          end
          columns.each do |column|
            into.send(:wrap_object, column, attributes[column])
          end
        end
      end
    end
  end
end
