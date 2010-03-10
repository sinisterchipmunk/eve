module Eve
  class API
    module Services
      module Map
        %w(sovereignty kills jumps).each do |service|
          define_method service.underscore do
            request('map', service)
          end
        end
      end
    end
  end
end
