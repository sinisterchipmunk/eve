module Eve
  class API
    module Connectivity
      def request(namespace, service_name)
        Eve::API::Request.new(namespace, service_name, options).dispatch
      end
    end
  end
end
