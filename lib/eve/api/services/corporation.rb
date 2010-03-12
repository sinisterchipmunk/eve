module Eve
  class API
    module Services
      module Corporation
        # limited or no API key
        def corporation_sheet(corporation_id = nil)
          request(:corp, :corporation_sheet, {:corporation_id => corporation_id}.optionalize)
        end

        # limited API key
        %w(fac_war_stats medals member_medals).each do |method_name|
          define_method(method_name) do
            validate_credentials :limited, :character_id
            request(:corp, method_name)
          end
        end

        # full API key
        %w(account_balance asset_list container_log industry_jobs market_orders member_security member_security_log
           member_tracking shareholders standings titles
          ).each do |method_name|
          define_method(method_name) do
            validate_credentials :full, :character_id
            request(:corp, method_name)
          end
        end

        def starbase_detail(item_id, version = 2)
          validate_credentials :full, :character_id
          request(:corp, :starbase_detail, {:item_id => item_id, :version => version})
        end

        def starbase_list
          validate_credentials :full, :character_id
          request(:corp, :starbase_list, :version => 2)
        end

        def kill_log(options = {})
          validate_credentials :full, :character_id
          options.reverse_merge!({:walk => false, :walk_id => 'before_kill_id', :walk_association => 'kills' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:corp, :kill_log, options)
        end

        def wallet_journal(account_key = 1000, options = {})
          validate_credentials :full, :character_id
          if account_key.kind_of?(Hash)
            options.merge! account_key
            account_key = 1000
          end
          options.reverse_merge!({:walk => false, :walk_id => 'before_ref_id', :walk_association => 'entries' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:corp, :wallet_journal, options.merge(:account_key => account_key))
        end

        def wallet_transactions(account_key = 1000, options = {})
          validate_credentials :full, :character_id
          if account_key.kind_of?(Hash)
            options.merge! account_key
            account_key = 1000
          end
          options.reverse_merge!({:walk => false, :walk_id => 'before_trans_id', :walk_association => 'transactions' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:corp, :wallet_journal, options.merge(:account_key => account_key))
        end
      end
    end
  end
end
