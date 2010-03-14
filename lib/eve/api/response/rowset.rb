module Eve
  class API
    class Response
      class Rowset < Array
        include Inspection
        include WrapObject
        attr_reader :name, :primary_key, :columns
        alias key primary_key

        def initialize(elem, options = {})
          super()
          @options = options
          parse_elem(elem)
        end

        def delegate_from(object)
          klass = class << object; self; end
          var_name = name.underscore
          object.instance_variable_set("@#{var_name}", self)
          klass.send(:attr_reader, var_name)
          klass.send(:alias_method, var_name.camelize.dehumanize, var_name)
        end

        def to_yaml(*args)
          to_a.to_yaml(*args)
        end

        private
        def parse_elem(elem)
          raise ArgumentError, "Expected an Hpricot::Elem, got #{elem.class}" unless elem.kind_of?(Hpricot::Elem)
          raise ArgumentError, "Expected a rowset element, got #{elem.name}" unless elem.name == 'rowset'

          @name = elem['name']
          @primary_key = elem['key']
          @columns = elem['columns'].split(/,/).collect { |c| c.strip }

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
          row = Eve::API::Response.new(elem, @options)
          row.copy_attributes(columns, elem)
          row.send(:parse_children, elem)
          self << row
        end
      end
    end
  end
end
