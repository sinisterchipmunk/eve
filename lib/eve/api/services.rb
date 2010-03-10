require 'eve/api/services/server'

module Eve
  class API
    module Services
      def self.included(base)
        base.instance_eval do
          include Eve::API::Services::Server
        end
      end
    end
  end
end
