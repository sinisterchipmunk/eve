module Eve
  class API
    class Response
      module Rowsets
        def rowset_names
          rowsets.collect { |c| puts c.name; c.name }
        end

        def add_rowset(rowset)
          rowsets << rowset
          rowset.delegate_from(self)
        end

        def rowsets; @rowsets ||= []; end

        def inspect
          "#<#{self.class.name}[#{rowset_names.join(', ')}]>"
        end
      end

      class Rowset < Array
        class Row
          include Eve::API::Response::Rowsets
          
          def initialize(columns, row_element, options = {})
            @options = options
            copy_attributes(columns, row_element)
            parse_children(row_element)
          end

          private
          def parse_children(row_element)
            row_element.children.each do |child|
              if child.kind_of?(Hpricot::Elem)
                case child.name
                  when 'rowset' then add_rowset(Rowset.new(child, @options))
                  else #raise ArgumentError, "Only more rowsets can be children of rows"
                end
              end
            end if row_element.children
          end

          def copy_attributes(columns, row_element)
            attributes = row_element.attributes.to_hash.rename((@options[:column_mapping] || {}))
            #missing_attributes = columns - attributes.keys
            #extra_attributes = attributes.keys - columns
            #raise Eve::Errors::InvalidRowset,
            #      "Missing attributes from row: #{missing_attributes.inspect}" if !missing_attributes.empty?
            #raise Eve::Errors::InvalidRowset,
            #      "Extra attributes in row: #{extra_attributes.inspect}" if !extra_attributes.empty?

            eigenclass = class << self; self; end
            columns.each do |column|
              value = attributes[column]
              eigenclass.send(:define_method, column.to_s.underscore) { value }
              eigenclass.send(:alias_method, column, column.to_s.underscore)
            end
          end
        end
        
        attr_reader :name, :key, :columns

        def initialize(elem, options = {})
          super()
          @options = options
          parse_elem(elem)
        end

        def inspect
          "#<Eve::API::Response::Rowset[#{name}][#{size}]>"
        end

        def delegate_from(object)
          klass = class << object; self; end
          var_name = name.underscore
          object.instance_variable_set("@#{var_name}", self)
          klass.send(:attr_reader, var_name)
          klass.send(:alias_method, var_name.camelize.dehumanize, var_name)
        end

        private
        def parse_elem(elem)
          raise ArgumentError, "Expected an Hpricot::Elem, got #{elem.class}" unless elem.kind_of?(Hpricot::Elem)
          raise ArgumentError, "Expected a rowset element, got #{elem.name}" unless elem.name == 'rowset'

          @name = elem['name']
          @key = elem['key']
          @columns = elem['columns'].split(/,/)

          elem.children.each do |child|
            if child.is_a?(Hpricot::Elem)
              case child.name
                when 'row' then parse_row(child)
                else raise "Expected a row element, got #{child.name.inspect}"
              end
            end
          end if elem.children
        end

        def parse_row(elem)
          self << Row.new(columns, elem, @options)
        end
      end
    end
  end
end
