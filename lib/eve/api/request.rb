module Eve
  class API
    class Request
      extend ActiveSupport::Memoizable
      attr_reader :response, :uri, :options, :namespace, :service
      
      def initialize(namespace, service, options = {})
        options.reverse_merge! default_options
        namespace = namespace.to_s if namespace.is_a?(Symbol)
        service   = service.to_s   if service.is_a?(Symbol)

        unless [:xml,:string].include? options[:response_type]
          raise ArgumentError, "Expected :response_type to be :xml or :string"
        end

        @options = options.dup
        @service = options[:camelize] ? service.camelize : service
        @namespace = namespace
        @response_type = options[:response_type]

        @uri = File.join(@options.delete(:base_uri), @namespace, "#{@service}.#{options[:extension]}")
      end

      def dispatch
        r = (cached_response || cache_response(Net::HTTP.post_form(URI.parse(uri), post_options).body))
        if r.respond_to?(:error) && r.error
          Eve::Errors.raise(:code => r.error.code, :message => r.error)
        end
        r
      end

      def cached_response
        if xml = (options[:cache] ? Eve.cache.read(cache_key) : nil)
          potential_response = response_for(xml)
          if !potential_response.respond_to?(:cached_until) || potential_response.cached_until >= Time.now
            return potential_response
          end
        end
        nil
      end

      def response_for(body)
        @response_type == :xml ? Eve::API::Response.new(body, options) : body
      end

      def cache_response(xml)
        Eve.cache.write(cache_key, xml) if options[:cache]
        response_for xml
      end

      def cache_key
        ActiveSupport::Cache.expand_cache_key(post_options, @uri)
      end

      memoize :cache_key

      private
      def post_options
        options.without(default_options.keys).camelize_keys
      end

      def default_options
        {
          :base_uri => "http://api.eve-online.com",
          :extension => "xml.aspx",
          :camelize => true,
          :response_type => :xml,
          :column_mapping => nil,
          :cache => true
        }
      end
    end
  end
end
