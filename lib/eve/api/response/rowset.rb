module Eve
  class API
    class Response
      class Rowset < Array
        class Row
          attr_reader :rowset
          delegate :[], :count, :length, :name, :columns, :key, :to => :rowset

          def initialize(columns, row_element)
            copy_attributes(columns, row_element)
            parse_children(row_element)
          end

          private
          def parse_children(row_element)
            row_element.children.each do |child|
              if child.kind_of?(Hpricot::Elem)
                case child.name
                  when 'rowset' then (@rowset = Rowset.new(child)).delegate_from(self)
                  else #raise ArgumentError, "Only more rowsets can be children of rows"
                end
              end
            end if row_element.children
          end

          def copy_attributes(columns, row_element)
            attributes = row_element.attributes.to_hash
            missing_attributes = columns - attributes.keys
            extra_attributes = attributes.keys - columns
            raise Eve::Errors::InvalidRowset,
                  "Missing attributes from row: #{missing_attributes.inspect}" if !missing_attributes.empty?
            raise Eve::Errors::InvalidRowset,
                  "Extra attributes in row: #{extra_attributes.inspect}" if !extra_attributes.empty?

            eigenclass = class << self; self; end
            attributes.each do |key, value|
              eigenclass.send(:define_method, key.to_s.underscore) { value }
              eigenclass.send(:alias_method, key, key.to_s.underscore)
            end
          end
        end
        
        attr_reader :name, :key, :columns

        def initialize(elem)
          super()
          parse_elem(elem)
        end

        def delegate_from(object)
          klass = class << object; self; end
          var_name = name.underscore
          object.instance_variable_set("@#{var_name}", self)
          klass.send(:attr_reader, var_name)
          klass.send(:alias_method, var_name.camelize.dehumanize, var_name)
        end

        private
        #<rowset name="solarSystems" key="solarSystemID"
        #  columns="solarSystemID,allianceID,factionID,solarSystemName,corporationID">
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

        #<row solarSystemID="30000001" allianceID="0" factionID="500007" solarSystemName="Tanoo" corporationID="0" />
        def parse_row(elem)
          self << Row.new(columns, elem)
        end
      end
    end
  end
end
