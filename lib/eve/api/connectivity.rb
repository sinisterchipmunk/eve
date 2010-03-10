module Eve
  class API
    module Connectivity
      extend ActiveSupport::Memoizable

      def request(namespace, service_name)
        cached = cached_response(namespace, service_name)
        return cached if cached && cached.cached_until > Time.now.utc
        cache_response(namespace, service_name,
                       Response.new(Eve::API::Request.new(namespace, service_name, options).post!))
      end

      def cache_response(namespace, service_name, response)
        Eve.cache.write(cache_key(namespace, service_name), response)
        response
      end

      def cached_response(namespace, service_name)
        Eve.cache.read(cache_key(namespace, service_name))
      end

      def cache_key(namespace, service_name)
        namespace = namespace.to_s unless namespace.is_a?(String)
        service_name = service_name.to_s unless service_name.is_a?(String)
        File.join("eve-api-connectivity", namespace, service_name, cache_key_for_options)
      end

      def cache_key_for_options
        options.sort do |a, b|
          a[0].to_s <=> b[0].to_s
        end.collect do |arr|
          [safe_for_filesystem(arr[0]), safe_for_filesystem(arr[1])]
        end.join(".")
      end

      def safe_for_filesystem(k)
        k.to_s.gsub(/[^a-zA-Z0-9\-\_\.\;\&]/, '.').gsub(/\.\./, '')
      end

      memoize :cache_key
    end
  end
end
