module Eve
  class API
    module Services
      module Character
        MAX_JOURNAL_ENTRIES = 1000
        
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
        def kill_log(options = {:walk => false})
          r = request(:char, :kill_log)
          if options[:walk] && r.kills.count >= MAX_JOURNAL_ENTRIES
            begin
              min_kill_id = nil
              r.kills.each { |kill| min_kill_id = kill.kill_id if min_kill_id.nil? || min_kill_id > kill.kill_id }
              r.kills.concat kill_log(options.merge(:before_kill_id => min_kill_id))
            rescue Eve::Errors::UserInputErrors::KillsPreviouslyLoaded
              # walking is internal, so we should catch the error internally too.
            end
          end
          r
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
        def wallet_journal(account_key = 1000, options = { :walk => false, :before_ref_id => nil })
          r = request(:char, :wallet_journal, options.merge(:account_key => account_key))
          if options[:walk] && r.entries.count >= MAX_JOURNAL_ENTRIES
            begin
              min_ref_id = nil
              r.entries.each { |entry| min_ref_id = entry.ref_id if min_ref_id.nil? || min_ref_id > entry.ref_id }
              r.entries.concat wallet_journal(account_key, options.merge(:before_ref_id => min_ref_id))
            rescue Eve::Errors::UserInputErrors::WalletPreviouslyLoaded
              # walking is internal, so we should catch the error internally too.
            end
          end
          r
        end
        # full API key
        def wallet_transactions(options = {:walk => false})
          r = request(:char, :wallet_transactions, options)
          if options[:walk] && r.transactions.count >= MAX_JOURNAL_ENTRIES
            begin
              min_trans_id = nil
              r.transactions.each { |txn| min_trans_id = txn.transaction_id if min_trans_id.nil? || min_trans_id > txn.transaction_id }
              r.transactions.concat wallet_transactions(options.merge(:before_trans_id => min_trans_id))
            rescue Eve::Errors::UserInputErrors::InvalidBeforeTransID
              # walking is internal, so we should catch the error internally too.
            end
          end
          r
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
