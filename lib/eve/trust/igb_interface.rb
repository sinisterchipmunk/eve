module Eve
  module Trust
    class IgbInterface
      extend ActiveSupport::Memoizable
      attr_reader :request
      delegate :headers, :to => :request

      def initialize(request)
        @request = request
      end

      def trusted?
        trusted
      end

      def igb?
        request.user_agent && request.user_agent[/eve\-minibrowser/i]
      end

      def validation_string
        return @validation_string if @validation_string
        @validation_string ||= request.headers['HTTP_EVE_VALIDATION_STRING'] || request.headers['HTTP_EVE_VALIDATIONSTRING']
        unless @validation_string
          warn "Validation string (HTTP_EVE_VALIDATION_STRING) is only a request, and is not implemented yet"
        end
        @validation_string
      end

      %w(trusted server_ip char_name char_id corp_name corp_id alliance_name alliance_id region_name constellation_name
         solar_system_name station_name station_id corp_role).each do |method|
        define_method method do
          igb_variable_get(method)
        end
      end

      %w(militia_name militia_id region_id constellation_id solar_system_id ship_id system_security).each do |method|
        define_method method do
          igb_variable_get(method, "The IGB does not yet supply #{method} headers, so this will always be nil")
        end
      end

      # Removed from Dominion, so always returns nil
      def nearest_location
        igb_variable_get('nearest_location',
              "The nearest_location headers have been removed from the IGB as of Dominion, so this always returns nil.")
      end

      private
      def igb_variable_get(method_name, warning = nil)
        return_value = (
          v = headers["HTTP_EVE_#{method_name.camelize.upcase}"] || nil
          v = (YAML::load(v) rescue v) unless v.nil?
          v
        )
        warn warning if return_value.nil? && warning
        return_value
      end

      memoize :igb_variable_get
    end
  end
end
