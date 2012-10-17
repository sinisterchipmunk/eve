module Eve
  class API
    class Response
      autoload :Result, 'eve/api/response/result'
      autoload :Row,    'eve/api/response/row'
      autoload :Rowset, 'eve/api/response/rowset'

      include Eve::API::Response::Result
      attr_reader :rowsets
      attr_reader :api_version, :content
      alias_method :apiVersion, :api_version

      def initialize(xml, options = {})
        @options = options
        @rowsets = []

        if xml.kind_of? String
          @xml = Nokogiri::XML(xml).root
        else
          @xml = xml
        end

        unless options[:process_xml] == false
          @api_version = @xml.attributes['version'].value
          parse_children @xml
          result = @xml.xpath("//result")[0]
          parse_children result if result
          all_fields << 'api_version'
          all_fields.delete 'result'
        end
      end
    end
  end
end
