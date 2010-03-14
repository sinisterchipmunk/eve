module Eve
  class API
    module Services
      module Server
        # Returns the current server status.
        #
        #  >> puts Eve::API.new.server_status.to_yaml
        #  ---
        #  current_time: 2010-03-14T04:41:51+00:00
        #  cached_until: 2010-03-14T04:44:51+00:00
        #  online_players: 30694
        #  server_open: true
        #  api_version: "2"
        def server_status
          request(:server, :server_status)
        end
      end
    end
  end
end
