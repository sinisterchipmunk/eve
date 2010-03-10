require 'eve/api/services/map'
require 'eve/api/services/misc'
require 'eve/api/services/server'

module Eve
  class API
    module Services
      def self.included(base)
        base.instance_eval do
          include Eve::API::Services::Misc
          include Eve::API::Services::Server
        end
      end
    end
  end
end
