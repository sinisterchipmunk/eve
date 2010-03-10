module Eve
  class API
    class Request
      extend ActiveSupport::Memoizable
      attr_reader :response, :uri, :options, :namespace, :service
      
      def initialize(namespace, service, options = {:base_uri => "http://api.eve-online.com"})
        namespace = namespace.to_s if namespace.is_a?(Symbol)
        service   = service.to_s   if service.is_a?(Symbol)
        
        @options = options.dup
        @service = service.camelize
        @namespace = namespace
        @uri = File.join(@options.delete(:base_uri), @namespace, "#{@service}.xml.aspx")
      end

      def dispatch
        cached_response || cache_response(Net::HTTP.post_form(URI.parse(uri), options).body)
      end

      def cached_response
        if xml = Eve.cache.read(cache_key)
          potential_response = Eve::API::Response.new(xml)
          return potential_response if potential_response.cached_until >= Time.now
        end
        nil
      end

      def cache_response(xml)
        Eve.cache.write(cache_key, xml)
        Eve::API::Response.new(xml)
      end

      def cache_key
        ActiveSupport::Cache.expand_cache_key(options, @uri)
      end

      memoize :cache_key
    end
  end
end
