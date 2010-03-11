module Eve
  class API
    module Services
      module Character
        def character_sheet; request(:character, :character_sheet); end
        def fac_war_stats; request(:character, :character_sheet); end
        def medals; request(:character, :character_sheet); end
        def skill_in_training; request(:character, :character_sheet); end
        def skill_queue; request(:character, :character_sheet); end
        def standings; request(:character, :character_sheet); end

        %w(character_sheet fac_war_stats medals skill_in_training skill_queue standings).each do |method_name|
          define_method "#{method_name}_with_credential_validation" do
            validate_credentials(:limited, :character_id)
            send("#{method_name}_without_credential_validation")
          end

          alias_method_chain method_name, :credential_validation
        end
      end
    end
  end
end
