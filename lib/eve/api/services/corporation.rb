module Eve
  class API
    module Services
      module Corporation
        # limited or no API key
        def corporation_sheet(corporation_id = nil)
          request(:corp, :corporation_sheet, {:corporation_id => corporation_id}.optionalize)
        end

        # limited API key
        def fac_war_stats
          validate_credentials :limited, :character_id
          request(:corp, :fac_war_stats)
        end

        # limited API key
        def medals
          validate_credentials :limited, :character_id
          request(:corp, :medals)
        end

        # limited API key
        def member_medals
          validate_credentials :limited, :character_id
          request(:corp, :member_medals)
        end

        # full API key
        def account_balance
          validate_credentials :full, :character_id
          request(:corp, :account_balance)
        end

        # full API key
        def asset_list
          validate_credentials :full, :character_id
          request(:corp, :asset_list)
        end

        # full API key
        def container_log
          validate_credentials :full, :character_id
          request(:corp, :container_log)
        end

        # full API key
        def industry_jobs
          validate_credentials :full, :character_id
          request(:corp, :industry_jobs)
        end

        # full API key
        def market_orders
          validate_credentials :full, :character_id
          request(:corp, :market_orders)
        end

        # full API key
        def member_security
          validate_credentials :full, :character_id
          request(:corp, :member_security)
        end

        # full API key
        def member_security_log
          validate_credentials :full, :character_id
          request(:corp, :member_security_log)
        end

        # full API key
        def member_tracking
          validate_credentials :full, :character_id
          request(:corp, :member_tracking)
        end

        # full API key
        def shareholders
          validate_credentials :full, :character_id
          request(:corp, :shareholders)
        end

        # full API key
        def standings
          validate_credentials :full, :character_id
          request(:corp, :standings)
        end

        # full API key
        def titles
          validate_credentials :full, :character_id
          request(:corp, :titles)
        end

        def starbase_detail(item_id, version = 2)
          validate_credentials :full, :character_id
          request(:corp, :starbase_detail, {:item_id => item_id, :version => version})
        end

        def starbase_list
          validate_credentials :full, :character_id
          request(:corp, :starbase_list, :version => 2)
        end

        # This API call only returns 1000 entries. Often, you will need to gather all entries, and not just the
        # most recent 1000. If this is true for your application, simply pass the :walk option and this EVE library
        # will automatically "walk" backward in time until the server reports that there are no more entries available.
        #
        # Walking is disabled by default, so you need to pass the :walk => true option if you wish to enable this.
        def kill_log(options = {})
          validate_credentials :full, :character_id
          options.reverse_merge!({:walk => false, :walk_id => 'before_kill_id', :walk_association => 'kills' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:corp, :kill_log, options)
        end

        # This API call only returns 1000 entries. Often, you will need to gather all entries, and not just the
        # most recent 1000. If this is true for your application, simply pass the :walk option and this EVE library
        # will automatically "walk" backward in time until the server reports that there are no more entries available.
        #
        # Walking is disabled by default, so you need to pass the :walk => true option if you wish to enable this.
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

        # This API call only returns 1000 entries. Often, you will need to gather all entries, and not just the
        # most recent 1000. If this is true for your application, simply pass the :walk option and this EVE library
        # will automatically "walk" backward in time until the server reports that there are no more entries available.
        #
        # Walking is disabled by default, so you need to pass the :walk => true option if you wish to enable this.
        def wallet_transactions(account_key = 1000, options = {})
          validate_credentials :full, :character_id
          if account_key.kind_of?(Hash)
            options.merge! account_key
            account_key = 1000
          end
          options.reverse_merge!({:walk => false, :walk_id => 'before_trans_id', :walk_association => 'transactions' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:corp, :wallet_transactions, options.merge(:account_key => account_key))
        end
      end
    end
  end
end
