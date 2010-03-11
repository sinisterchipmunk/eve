require 'eve/api/response/rowset'

module Eve
  class API
    class Response
      include Eve::API::Response::Rowsets
      attr_reader :api_version

      def initialize(xml, options = {})
        @options = options
        xml = Hpricot::XML(xml).root if xml.kind_of?(String)
        @xml = xml
        @attributes = {}

        if error = (@xml / 'error').first
          message = error.inner_text
          code = error['code']
          Eve::Errors.raise(:code => code, :message => message)
        end

        parse_xml unless options[:process_xml] == false
      end

      protected
      def parse_xml(node = @xml)
        case node
          when Hpricot::Elem
            parse_elem(node)
        end
      end

      def check_for_datetime(value)
        if value =~ /\A[0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2}\z/
          DateTime.parse(value)
        else
          value
        end
      end

      def wrap_method_around_node(node = @xml)
        original_method_name = node.name
        method_name = original_method_name.underscore
        if node.children && !node.children.select { |c| c.is_a?(Hpricot::Elem) }.empty?
          value = Eve::API::Response.new(node, @options.merge(:process_xml => false))
          value.parse_children
        else
          value = YAML::load(node.inner_text)
          value = check_for_datetime(value)
        end

        @attributes[method_name] = value
        klass = class << self; self; end
        klass.instance_eval do
          define_method method_name do
            @attributes[method_name]
          end

          alias_method original_method_name, method_name
        end
      end

      def parse_elem(node = @xml)
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

      def parse_children(node = @xml)
        node.children.each { |child| parse_xml(child) } if node.children
      end
    end
  end
end
