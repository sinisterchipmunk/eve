require 'eve/api/response/rowset'

module Eve
  class API
    class Response
      attr_reader :xml, :api_version, :rowset
      delegate :[], :count, :length, :name, :columns, :key, :to => :rowset
      
      def initialize(xml)
        @xml = xml
        @attributes = {}
        @rowset = []

        parse_xml(Hpricot::XML(@xml).root)
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

#          define_method "#{method_name}=" do |value|
#            @attributes[method_name] = value
#          end

          alias_method original_method_name, method_name
#          alias_method "#{original_method_name}=", "#{method_name}="
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
            node.children.each { |child| parse_xml(child) } if node.children
          when 'result' then
            node.children.each { |child| parse_xml(child) } if node.children
          when 'rowset' then
            @rowset = Rowset.new(node)
          else wrap_method_around_node(node)
        end
      end
    end
  end
end
