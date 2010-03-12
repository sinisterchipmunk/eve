module Eve
  class API
    module Services
      module Character
        #limited API key
        def character_sheet; request(:char, :character_sheet); end
        #limited API key
        def fac_war_stats; request(:char, :fac_war_stats); end
        #limited API key
        def medals; request(:char, :medals); end
        #limited API key
        def skill_in_training; request(:char, :skill_in_training); end
        #limited API key
        def skill_queue; request(:char, :skill_queue); end
        #limited API key
        def standings; request(:char, :standings); end

        %w(character_sheet fac_war_stats medals skill_in_training skill_queue standings).each do |method_name|
          define_method "#{method_name}_with_credential_validation" do
            validate_credentials(:limited, :character_id)
            send("#{method_name}_without_credential_validation")
          end

          alias_method_chain method_name, :credential_validation
        end

        # full API key
        def account_balance; request(:char, :account_balance); end
        # full API key
        def asset_list(version = nil)
          options = {}
          options[:version] = version if version
          request(:char, :asset_list)
        end
        # full API key
        def industry_jobs; request(:char, :industry_jobs); end
        # full API key
        def kill_log(options = {})
          options.reverse_merge!({:walk => false, :walk_id => 'kill_id', :walk_association => 'kills' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:char, :kill_log, options)
        end
        # full API key
        def mailing_lists; request(:char, :mailing_lists); end
        # full API key
        def mail_messages; request(:char, :mail_messages); end
        # full API key
        def market_orders; request(:char, :market_orders); end
        # full API key
        def notifications; request(:char, :notifications); end
        # full API key
        def research; request(:char, :research); end
        # full API key
        def wallet_journal(account_key = 1000, options = { })
          if account_key.kind_of?(Hash)
            options = account_key
            account_key = 1000
          end
          options.reverse_merge!({:walk => false, :walk_id => 'ref_id', :walk_association => 'entries' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:char, :wallet_journal, options.merge(:account_key => account_key))
        end
        # full API key
        def wallet_transactions(options = {})
          options.reverse_merge!({:walk => false, :walk_id => 'trans_id', :walk_association => 'transactions' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:char, :wallet_transactions, options)
        end

        %w(account_balance asset_list industry_jobs kill_log mailing_lists mail_messages market_orders notifications
           research wallet_journal wallet_transactions).each do |method_name|
          define_method "#{method_name}_with_credential_validation" do |*a|
            validate_credentials(:full, :character_id)
            send("#{method_name}_without_credential_validation", *a)
          end

          alias_method_chain method_name, :credential_validation
        end

        alias journal_entries wallet_journal
      end
    end
  end
end
