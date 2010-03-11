module Eve
  class API
    module Services
      module Eve
        def alliance_list;     request(:eve, :alliance_list);     end
        def certificate_tree;  request(:eve, :certificate_tree, :column_mapping => { 'level' => 'skillLevel' });  end
        def conquerable_station_list; request(:eve, :conquerable_station_list); end
        
      end
    end
  end
end
