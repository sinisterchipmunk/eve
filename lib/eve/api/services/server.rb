module Eve
  class API
    module Services
      module Server
        def server_status
          request(:server, :server_status)
        end
      end
    end
  end
end
