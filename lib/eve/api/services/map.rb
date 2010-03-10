module Eve
  class API
    module Services
      module Map
        def sovereignty
          request('map', 'sovereignty')
        end
      end
    end
  end
end
