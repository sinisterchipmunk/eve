require 'eve/api/response/inspection'
require 'eve/api/response/wrap_object'
require 'eve/api/response/rowsets'
require 'eve/api/response/rowset'

module Eve
  class API
    class Response
      include Eve::API::Response::WrapObject
      include Eve::API::Response::Rowsets
      include Eve::API::Response::Inspection
      attr_reader :api_version, :content

      def initialize(xml, options = {})
        @options = options
        xml = Hpricot::XML(xml).root if xml.kind_of?(String)
        @xml = xml
        #@attributes = {}

        parse_xml unless options[:process_xml] == false
      end

      def to_hash
        hash = {}
        (instance_variables - protected_instance_variables + (@name.blank? ? [] : ["@name"])).each do |ivar|
          value = instance_variable_get(ivar)
          value = case value
            when Rowset then value.to_a
            when Response then value.to_hash
            else value
          end
          hash[ivar[1..-1]] = value
        end
        hash
      end

      def to_yaml(*args)
        to_hash.to_yaml(*args)
      end

      def [](key)
        key = key.to_s if !key.kind_of?(String)
        key = key.underscore
        instance_variable_get("@#{key}") ||
                raise(ArgumentError, "No attribute called '#{key}' seems to exist in #{self.inspect}")
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
        # TODO: refactor me.
        if !node.children || !node.children.select { |c| c.is_a?(Hpricot::Elem) }.empty?
          @content = node.inner_text.strip if !node.children
          value = Eve::API::Response.new(node, @options.merge(:process_xml => false))
          value.send(:copy_attributes, node.attributes.to_hash.keys, node)
          value.parse_children
        else
          value = value_for(node.inner_text)
          value = check_for_datetime(value)
          # now define any attributes as methods on the resultant object
          node_attributes = node.attributes.to_hash
          copy_attributes(node_attributes.keys, node, value)
        end

        wrap_object(node.name, value)
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
