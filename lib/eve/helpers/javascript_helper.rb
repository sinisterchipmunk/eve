module Eve
  module Helpers
    module JavascriptHelper
      # Returns the numeric type ID for a string, so you don't have to manage "magic numbers" in your application.
      # The argument can be a string or a symbol, and is case insensitive. Underscores will be converted to spaces.
      #
      # Examples:
      #   type_id('alliance')       # => 16159
      #   type_id('character')      # => 1377
      #   type_id('corporation')    # => 2
      #   type_id('constellation')  # => 4
      #   type_id('region')         # => 3
      #   type_id('Solar System')   # => 5
      #   type_id(:solar_system)    # => 5
      #   type_id(:station)         # => 3867
      #
      def type_id(which)
        which = which.to_s.humanize unless which.kind_of?(String)
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

      # Creates a hyperlink that results in opening the client's EVE mail inbox.
      def link_to_evemail(text, *args)
        link_to_function(text, "CCPEVE.openEveMail()", *args)
      end

      # Creates a hyperlink that results in the "show info" dialog being displayed on the client's screen.
      # If item_id is given, the show info window will open for that item.
      #
      #  type_id (Number)
      #    Type ID of item to show info on.
      #  item_id (Number)
      #    Optional item ID of specific item of type type_id to show info on. This is required for specific types of
      #    items, such as solar systems, stations, regions, and constellations.
      #
      def link_to_info(text, type_id, item_id = nil, *args)
        function = "CCPEVE.showInfo(#{type_id.inspect}"
        function.concat ", #{item_id.inspect}" if item_id
        function.concat ")"
        link_to_function text, function, *args
      end

      # Creates a hyperlink that results in opening the preview window for type_id.
      #
      #  type_id (Number)
      #    Type ID of item to preview.
      #
      def link_to_preview(text, type_id, *args)
        link_to_function text, "CCPEVE.showPreview(#{type_id.inspect})", *args
      end

      # Creates a hyperlink that results in showing the route to the destination_id from the source_id.
      # If source_id is not given, the source system is taken to be the system the user is currently in.
      #
      def link_to_route(text, destination_id, source_id = nil, *args)
        function = "CCPEVE.showRouteTo(#{destination_id.inspect}"
        function.concat ", #{source_id.inspect}" if source_id
        function.concat ")"
        link_to_function text, function, *args
      end

      # Creates a hyperlink that results in opening the map. If system_id is given, the map will focus on that system.
      #
      #  system_id (Number)
      #    Optional ID of solar system to focus map on.
      #
      def link_to_map(text, system_id = nil, *args)
        link_to_function text, "CCPEVE.showMap(#{system_id ? system_id.inspect : ''})", *args
      end

      # Creates a hyperlink that results in opening the fitting window and displays the fitting represented by fitting.
      #
      #  fitting (String)
      #    A Ship DNA string.
      #
      # See http://wiki.eveonline.com/en/wiki/Ship_DNA for details
      def link_to_fitting(text, ship_dna_string, *args)
        link_to_function text, "CCPEVE.showFitting(#{ship_dna_string.inspect})", *args
      end

      # Creatse a hyperlink that results in opening the contract window and displaying the contract represented by the
      # contract_id argument. Contracts are, however, assigned per-solar-system, and so a solar_system_id must also be
      # provided.
      #
      #  solar_system_id (Number)
      #    The ID number of the solar system in which the contract is located.
      #  contract_id (Number)
      #    The ID number of the contract to display.
      def link_to_contract(text, solar_system_id, contract_id, *args)
        link_to_function text, "CCPEVE.showContract(#{solar_system_id.inspect}, #{contract_id.inspect})", *args
      end

      # Creates a hyperlink which results in opening the market details window and displays the information about the
      # item represented by type_id.
      #
      #  typeID (Number)
      #    Type ID to display market details about
      #
      def link_to_market_details(text, type_id, *args)
        link_to_function text, "CCPEVE.showMarketDetails(#{type_id.inspect})", *args
      end

      # Produces a hyperlink that will result in a pop-up a trust prompt in the client, allowing the user to either
      # grant the trust request, ignore it, or always ignore trust requests from your site.
      #
      #  trust_url (String)
      #    This is a fully-qualified domain name and path (e.g. http://wiki.eveonline.com/w/) to which your site would
      #    like the user to grant trust.
      #
      # The page will not be automatically refreshed if the user grants the trust request. Trust will take effect the
      # next time the user refreshes the page, or navigates within the site.
      #
      # Note that trust_url is processed and only the protocol, domain and path will be used from it. If you supply a
      # query string or anchor, they will be discarded. It is recommended that you primarily pass in only
      # fully-qualified domain names without paths (e.g. http://wiki.eveonline.com instead of
      # http://wiki.eveonline.com/w/index.php), as this avoids pestering the user for trust on every page.
      #
      def link_to_trust_request(text, trust_url = "http://#{request.host}/", *args)
        trust_url = url_for(trust_url.merge(:only_path => false)) if trust_url.kind_of?(Hash)
        link_to_function text, "CCPEVE.requestTrust(#{trust_url.inspect})", *args
      end

      # This will generate a method call that produces a pop-up a trust prompt in the client, allowing the user to
      # either grant the trust request, ignore it, or always ignore trust requests from your site.
      #
      #  trust_url (String)
      #    This is a fully-qualified domain name and path (e.g. http://wiki.eveonline.com/w/) to which your site would
      #    like the user to grant trust.
      #
      # The page will not be automatically refreshed if the user grants the trust request. Trust will take effect the
      # next time the user refreshes the page, or navigates within the site.
      #
      # Note that trust_url is processed and only the protocol, domain and path will be used from it. If you supply a
      # query string or anchor, they will be discarded. It is recommended that you primarily pass in only
      # fully-qualified domain names without paths (e.g. http://wiki.eveonline.com instead of
      # http://wiki.eveonline.com/w/index.php), as this avoids pestering the user for trust on every page.
      #
      def request_trust(trust_url = "http://#{request.host}/", *args)
        trust_url = url_for(trust_url.merge(:only_path => false)) if trust_url.kind_of?(Hash)
        javascript_tag "CCPEVE.requestTrust(#{trust_url.inspect});", *args
      end

      # Sets the client's autopilot destination to the specified solar system.
      #
      #  solar_system_id (Number)
      #    The numerical identifier of the solar system to which you wish to set the client's autopilot destination.
      #
      # This method requires that the user grant Trust to the calling site.
      def link_to_destination(text, solar_system_id, *args)
        link_to_function text, "CCPEVE.setDestination(#{solar_system_id.inspect})", *args
      end

      # Adds the specified solar system to the end of the client's autopilot route. If the solar system is already in
      # the route, no changes are made and the method fails silently.
      #
      #  solar_system_id (Number)
      #    The numerical identifier of the solar system which you wish to append to the client's autopilot route.
      #
      # This method requires that the user grant Trust to the calling site.
      def link_to_waypoint(text, solar_system_id, *args)
        link_to_function text, "CCPEVE.addWaypoint(#{solar_system_id.inspect})", *args
      end

      # Causes the user to attempt to join the named channel. Normal channel access control rules apply. If the user is
      # unable to join the channel, the method fails silently.
      #
      #  channel_name (String)
      #    The name of the channel which the user will join.
      #
      # This method requires that the user grant Trust to the calling site.
      def link_to_channel(text, channel_name, *args)
        link_to_function text, "CCPEVE.joinChannel(#{channel_name.inspect})", *args
      end

      # Causes the user to subscribe to the named mailing list.
      #
      #  mailing_list_name (String)
      #    The name of the mailing list which the user will join.
      #
      # This method requires that the user grant Trust to the calling site.
      def link_to_mailing_list(text, mailing_list_name, *args)
        link_to_function text, "CCPEVE.joinMailingList(#{mailing_list_name.inspect})", *args
      end
    end
  end
end
