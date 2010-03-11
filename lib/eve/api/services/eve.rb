module Eve
  class API
    module Services
      module Eve
        def alliance_list;     request(:eve, :alliance_list);     end
        def certificate_tree;  request(:eve, :certificate_tree, :column_mapping => { 'level' => 'skillLevel' });  end
        def conquerable_station_list; request(:eve, :conquerable_station_list); end
        def error_list; request(:eve, :error_list); end
        def fac_war_stats; request(:eve, :fac_war_stats); end
        def fac_war_top_stats; request(:eve, :fac_war_top_stats); end

        alias factional_warfare_stats fac_war_stats
        alias factional_warfare_top100 fac_war_top_stats
      end
    end
  end
end
