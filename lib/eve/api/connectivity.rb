module Eve
  class API
    module Connectivity
      def request(namespace, service_name, options = {})
        Eve::API::Request.new(namespace, service_name, self.options.merge(options)).dispatch
      end
    end
  end
end
