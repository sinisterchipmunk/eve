require 'eve/api/response/rowset'

module Eve
  class API
    class Response
      include Eve::API::Response::Rowsets
      attr_reader :xml, :api_version

      def inspect
        return self.to_s
      end
      
      def initialize(xml, options = {})
        @options = options
        xml = Hpricot::XML(xml).root if xml.kind_of?(String)
        @xml = xml
        @attributes = {}

        if error = (@xml / 'error').first
          message = error.inner_text
          code = error['code'].to_i
          if Eve::Errors::API_ERROR_MAP.key?(code)
            raise Eve::Errors::API_ERROR_MAP[code], message
          else
            code = "#{error['code'][0].chr}xx"
            if Eve::Errors::API_ERROR_MAP.key?(code)
              raise Eve::Errors::API_ERROR_MAP[code], message
            else
              raise "Unknown error, code #{error['code']} - #{message}"
            end
          end
        end
        parse_xml(@xml)
      end

      private
      def check_for_datetime(attrib)
        if @attributes[attrib] =~ /\A[0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2}\z/
          @attributes[attrib] = DateTime.parse(@attributes[attrib])
        end
      end

      def wrap_method_around_node(node)
        original_method_name = node.name
        method_name = original_method_name.underscore
        @attributes[method_name] = YAML::load(node.inner_text)
        check_for_datetime(method_name)
        klass = class << self; self; end
        klass.instance_eval do
          define_method method_name do
            @attributes[method_name]
          end

          alias_method original_method_name, method_name
        end
      end

      def parse_xml(node)
        case node
          when Hpricot::Elem
            parse_elem(node)
        end
      end

      def parse_elem(node)
        case node.name
          when 'eveapi' then
            @api_version = node['version']
            parse_children(node)
          when 'result' then
            parse_children(node)
          when 'rowset' then
            add_rowset Rowset.new(node, @options)
          else wrap_method_around_node(node)
        end
      end

      def parse_children(node)
        node.children.each { |child| parse_xml(child) } if node.children
      end
    end
  end
end
