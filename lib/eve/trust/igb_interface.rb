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

      # Validation string (HTTP_EVE_VALIDATION_STRING) is only a wishlist item, and is not actually implemented in the
      # IGB yet. However, if CCP implements it as written, this method should magically start working.
      def validation_string
      return @validation_string if @validation_string
        @validation_string ||= request.headers['HTTP_EVE_VALIDATION_STRING'] || request.headers['HTTP_EVE_VALIDATIONSTRING']
        unless @validation_string
          warn "Validation string (HTTP_EVE_VALIDATION_STRING) is only a request, and is not implemented yet"
        end
        @validation_string
      end

      def trusted; igb_variable_get(:trusted); end
      def server_ip; igb_variable_get(:server_ip); end
      def char_name; igb_variable_get(:char_name); end
      def char_id; igb_variable_get(:char_id); end
      def corp_name; igb_variable_get(:corp_name); end
      def corp_id; igb_variable_get(:corp_id); end
      def alliance_name; igb_variable_get(:alliance_name); end
      def alliance_id; igb_variable_get(:alliance_id); end
      def region_name; igb_variable_get(:region_name); end
      def constellation_name; igb_variable_get(:constellation_name); end
      def corp_role; igb_variable_get(:corp_role); end
      def station_id; igb_variable_get(:station_id); end
      def station_name; igb_variable_get(:station_name); end
      def solar_system_name; igb_variable_get(:solar_system_name); end

      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def militia_name; igb_variable_get(:militia_name, "The IGB does not yet supply :militia_name headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def militia_id; igb_variable_get(:militia_id, "The IGB does not yet supply :militia_id headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def region_id; igb_variable_get(:region_id, "The IGB does not yet supply :region_id headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def constellation_id; igb_variable_get(:constellation_id, "The IGB does not yet supply :constellation_id headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def solar_system_id; igb_variable_get(:solar_system_id, "The IGB does not yet supply :solar_system_id headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def ship_id; igb_variable_get(:ship_id, "The IGB does not yet supply :ship_id headers, so this will always be nil"); end
      # The IGB does not yet supply the proper headers for this method, so it will always return nil. However, if CCP
      # implements it as written, this method should magically start working.
      def system_security; igb_variable_get(:system_security, "The IGB does not yet supply :system_security headers, so this will always be nil"); end

      # Removed from Dominion, so always returns nil
      def nearest_location
        igb_variable_get('nearest_location',
              "The nearest_location headers have been removed from the IGB as of Dominion, so this always returns nil.")
      end

      private
      def igb_variable_get(method_name, warning = nil)
        return_value = (
          v = headers["HTTP_EVE_#{method_name.to_s.camelize.upcase}"] || nil
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
