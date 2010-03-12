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

        # full API key
        def account_balance; request(:char, :account_balance); end
        # full API key
        def asset_list(version = nil)
          request(:char, :asset_list, {:version => version}.optionalize)
        end
        # full API key
        def industry_jobs; request(:char, :industry_jobs); end
        # full API key
        def kill_log(options = {})
          options.reverse_merge!({:walk => false, :walk_id => 'before_kill_id', :walk_association => 'kills' })
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
          options.reverse_merge!({:walk => false, :walk_id => 'before_ref_id', :walk_association => 'entries' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:char, :wallet_journal, options.merge(:account_key => account_key))
        end
        # full API key
        def wallet_transactions(options = {})
          options.reverse_merge!({:walk => false, :walk_id => 'before_trans_id', :walk_association => 'transactions' })
          validate_options(options, :walk, :walk_id, :walk_association)
          request(:char, :wallet_transactions, options)
        end

        alias journal_entries wallet_journal

        def self.included(base)
          base.instance_eval do
            validate_credentials :limited, :character_id,
                                 :for => %w(character_sheet fac_war_stats medals skill_in_training skill_queue standings
                                           )
            validate_credentials :full, :character_id,
                                 :for => %w(account_balance asset_list industry_jobs kill_log mailing_lists
                                            mail_messages market_orders notifications research wallet_journal
                                            wallet_transactions journal_entries)
          end
        end
      end
    end
  end
end
