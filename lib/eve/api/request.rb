module Eve
  class API
    class Request
      attr_reader :response, :uri, :options
      
      def initialize(namespace, service, options = {:base_uri => "http://api.eve-online.com"})
        namespace = namespace.to_s if namespace.is_a?(Symbol)
        service   = service.to_s   if service.is_a?(Symbol)
        @options = options.dup
        base_uri = @options.delete :base_uri
        @uri = File.join(base_uri, namespace, "#{service.camelize}.xml.aspx")
      end

      def post!
        Net::HTTP.post_form(URI.parse(uri), options).body
      end

      def get!
        Net::HTTP.get(URI.parse("#{uri}?#{options.to_query}"))
      end
    end
  end
end
