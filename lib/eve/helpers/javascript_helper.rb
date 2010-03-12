module Eve
  module Helpers
    module JavascriptHelper
      def type_id(which)
        which = which.to_s unless which.kind_of?(String)
        which.downcase!
        case which
          when 'alliance' then 16159
          when 'character' then 1377
          when 'corporation' then 2
          when 'constellation' then 4
          when 'region' then 3
          when 'solar system', 'solarsystem' then 5
          when 'station' then 3867
          else raise ArgumentError, "Unknown type: #{which}"
        end
      end

      def link_to_evemail(text, *args)
        link_to_function(text, "CCPEVE.openEveMail()", *args)
      end

      def link_to_info(text, type_id, item_id = nil, *args)
        function = "CCPEVE.showInfo(#{type_id}"
        function.concat ", #{item_id}" if item_id
        function.concat ")"
        link_to_function text, function, *args
      end

      def link_to_preview(text, type_id, *args)
        link_to_function text, "CCPEVE.showPreview(#{type_id})", *args
      end

      def link_to_route(text, destination_id, source_id = nil, *args)
        function = "CCPEVE.showInfo(#{destination_id}"
        function.concat ", #{source_id}" if source_id
        function.concat ")"
        link_to_function text, function, *args
      end

      def link_to_map(text, system_id = nil, *args)
        link_to_function text, "CCPEVE.showMap(#{system_id})", *args
      end

      # See http://wiki.eveonline.com/en/wiki/Ship_DNA for details
      def link_to_fitting(text, ship_dna_string, *args)
        link_to_function text, "CCPEVE.showFitting(#{ship_dna_string})", *args
      end

      def link_to_contract(text, solar_system_id, contract_id, *args)
        link_to_function text, "CCPEVE.showContract(#{solar_system_id}, #{contract_id})", *args
      end

      def link_to_market_details(text, type_id, *args)
        link_to_function text, "CCPEVE.showMarketDetails(#{type_id})", *args
      end

      def link_to_trust_request(text, trust_url = "http://#{request.host}/", *args)
        trust_url = url_for(trust_url.merge(:only_path => false)) if trust_url.kind_of?(Hash)
        link_to_function text, "CCPEVE.requestTrust(#{trust_url.inspect})", *args
      end

      def request_trust(trust_url = "http://#{request.host}/", *args)
        trust_url = url_for(trust_url.merge(:only_path => false)) if trust_url.kind_of?(Hash)
        javascript_tag "CCPEVE.requestTrust(#{trust_url.inspect});", *args
      end

      # requires trust
      def link_to_destination(text, solar_system_id, *args)
        link_to_function text, "CCPEVE.setDestination(#{solar_system_id})", *args
      end

      # requires trust
      def link_to_waypoint(text, solar_system_id, *args)
        link_to_function text, "CCPEVE.addWaypoint(#{solar_system_id})", *args
      end

      # requires trust
      def link_to_channel(text, channel_name, *args)
        link_to_function text, "CCPEVE.joinChannel(#{channel_name.inspect})", *args
      end

      # requires trust
      def link_to_mailing_list(text, mailing_list_name, *args)
        link_to_function text, "CCPEVE.joinMailingList(#{mailing_list_name.inspect})", *args
      end
    end
  end
end
