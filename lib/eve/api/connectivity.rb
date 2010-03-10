module Eve
  class API
    module Connectivity
      def request(namespace, service_name)
        Response.new Eve::API::Request.new(namespace, service_name, options).post!
      end
    end
  end
end
