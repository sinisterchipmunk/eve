module Eve
  class API
    module Services
      module Map
        def sovereignty;     request('map', :sovereignty);     end
        def kills;           request('map', :kills);           end
        def jumps;           request('map', :jumps);           end
        def fac_war_systems; request('map', :fac_war_systems); end

        alias contested_systems fac_war_systems
      end
    end
  end
end
