module Eve
  class API
    class Response
      class Rowset < Array
        class Row
          def initialize(columns, attributes)
            attributes = attributes.to_hash
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
          self << Row.new(columns, elem.attributes)
        end
      end
    end
  end
end
