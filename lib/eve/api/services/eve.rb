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
        def skill_tree; request(:eve, :skill_tree); end

        def ref_types
          response = request(:eve, :ref_types)
          result = {}
          response.ref_types.each do |row|
            result[row.ref_type_id] = row.ref_type_name
          end
          result
        end

        def character(*names)
          response = request(:eve, :character_id, :names => names.flatten.join(','))
          result = {}
          [:characters, :corporations, :alliances].each do |field|
            if response.respond_to?(field)
              response.send(field).each { |row| result[row.name] = row.character_id }
            end
          end
          result
        end

        alias character_id character
        alias characters character
        alias corporation character
        alias corporation_id character
        alias corporations character
        alias alliance character
        alias alliance_id character
        alias alliances character

        alias factional_warfare_stats fac_war_stats
        alias factional_warfare_top100 fac_war_top_stats
      end
    end
  end
end
