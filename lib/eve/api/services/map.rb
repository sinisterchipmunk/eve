module Eve
  class API
    module Services
      module Map
        # Returns the sovereignty status of all solar systems. Warning: This is a lot of data!
        #
        # Returns an object with a single "solar_systems" array. Each element in the array contains:
        #   solar_system_id
        #   alliance_id
        #   faction_id
        #   corporation_id
        #   solar_system_name
        def sovereignty;     request('map', :sovereignty);     end

        # Returns the sovereignty status of all solar systems. Warning: This is a lot of data!
        #
        # Returns an object with a single "solar_systems" array. Each element in the array contains:
        #   solar_system_id
        #   ship_kills      (number)
        #   faction_kills   (number)
        #   pod_kills       (number)
        def kills;           request('map', :kills);           end

        # Returns the sovereignty status of all solar systems. Warning: This is a lot of data!
        #
        # Returns an object with a single "solar_systems" array. Each element in the array contains:
        #   solar_system_id
        #   ship_jumps      (number)
        def jumps;           request('map', :jumps);           end

        # Returns the sovereignty status of all solar systems. Warning: This is a lot of data!
        #
        # Returns an object with a single "solar_systems" array. Each element in the array contains:
        #   solar_system_id
        #   solar_system_name
        #   occupying_faction_id
        #   occupying_faction_name
        #   contested              (boolean)
        def fac_war_systems; request('map', :fac_war_systems); end

        alias contested_systems fac_war_systems
      end
    end
  end
end
