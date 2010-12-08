require 'eve/api/request'
require 'eve/api/response'
require 'eve/api/services'
require 'eve/api/connectivity'

module Eve
  # = Eve API Libraries
  #
  # EVE Online has made available various APIs which allow for querying the server for information about the server's
  # current status, general game information such as skill and certificate trees, top player rankings, and the players
  # and characters themselves. This library interfaces with that API to provide an intuitive way of retrieving this
  # data.
  #
  # == The Basics
  #
  # There are two forms of authentication that the API uses: a limited API key and a full API key. For some information,
  # such as the server's current status, no API key at all is required; for other information, such as which characters
  # are owned by a particular user account, a limited API key will suffice. For more personal information, such as
  # a character's transaction history, a full API key is required. Using an inappropriate or missing API key will result
  # in an error being raised.
  #
  # === Instantiation & [Re]Configuration
  # To interface with the Eve API, you need to instantiate the API object. This is simple:
  #   api = Eve::API.new
  #
  # If you plan to make use of information requiring an API key, you'll need to pass in those options:
  #   api = Eve::API.new(:user_id => 'a_user_id', :api_key => 'an_api_key')
  #
  # If you need to make use of Character-specific API calls, then you should also pass a +:character_id+ key. Same goes
  # for Corporation-specific API calls: pass a +corporation_id+ key. If you don't know those yet (for instance, because
  # you need the user to make a selection), then don't fret. You can always instantiate a new API object, or simply
  # set the option directly on the API object you've already got:
  #   api.set(:character_id => 'a_character_id')
  #   # -or-
  #   api[:character_id] = 'a_character_id'
  #
  # === Making API Calls
  # Actually retrieving information is just as straightforward as instantiation of the API object was, though the syntax
  # does sometimes vary from one call to the next. Here's how to get the current server status:
  #   status = api.server_status
  #
  # And retrieving the list of characters belonging to :user_id is done like so:
  #   charlist = api.account.characters
  #
  # === List of API Calls
  # This section is split into 3 subsections, one for each level of API key required for the call in question. This
  # table assumes the presence of an "api" object, which is an instantiation of the API object as shown above. For
  # more information on a particular subset of calls, including the exact return values, click on the corresponding
  # class name to the left.
  #
  # ==== No API Key
  # Eve::API::Services::Corporation:: api.corporation.corporation_sheet
  # Eve::API::Services::Eve::         api.eve.alliance_list
  # Eve::API::Services::Eve::         api.eve.certificate_tree
  # Eve::API::Services::Eve::         api.eve.conquerable_station_list
  # Eve::API::Services::Eve::         api.eve.error_list
  # Eve::API::Services::Eve::         api.eve.fac_war_stats / api.eve.factional_warfare_stats
  # Eve::API::Services::Eve::         api.eve.fac_war_top_stats / api.eve.factional_warfare_top100
  # Eve::API::Services::Eve::         api.eve.character_name(*ids)
  # Eve::API::Services::Eve::         api.eve.character_id(*names)
  # Eve::API::Services::Eve::         api.eve.corporation_name(*ids)
  # Eve::API::Services::Eve::         api.eve.corporation_id(*names)
  # Eve::API::Services::Eve::         api.eve.alliance_name(*ids)
  # Eve::API::Services::Eve::         api.eve.alliance_id(*names)
  # Eve::API::Services::Eve::         api.eve.ref_types
  # Eve::API::Services::Eve::         api.eve.skill_tree
  # Eve::API::Services::Map::         api.map.fac_war_systems / api.map.contested_systems
  # Eve::API::Services::Map::         api.map.sovereignty
  # Eve::API::Services::Map::         api.map.kills
  # Eve::API::Services::Map::         api.map.jumps
  # Eve::API::Services::Misc::        api.misc.character_portrait
  # Eve::API::Services::Server::      api.server.server_status
  #
  # ==== Limited API Key
  # Eve::API::Services::Account::     api.account.characters
  # Eve::API::Services::Character::   api.character.character_sheet
  # Eve::API::Services::Character::   api.character.fac_war_stats
  # Eve::API::Services::Character::   api.character.medals
  # Eve::API::Services::Character::   api.character.skill_in_training
  # Eve::API::Services::Character::   api.character.skill_queue
  # Eve::API::Services::Character::   api.character.standings
  # Eve::API::Services::Corporation:: api.corporation.corporation_sheet
  # Eve::API::Services::Corporation:: api.corporation.fac_war_stats
  # Eve::API::Services::Corporation:: api.corporation.medals
  # Eve::API::Services::Corporation:: api.corporation.member_medals
  #
  # ==== Full API Key
  # Eve::API::Services::Character::   api.character.account_balance
  # Eve::API::Services::Character::   api.character.asset_list(version = nil)
  # Eve::API::Services::Character::   api.character.industry_jobs
  # Eve::API::Services::Character::   api.character.kill_log(options = {})
  # Eve::API::Services::Character::   api.character.mailing_lists
  # Eve::API::Services::Character::   api.character.mail_messages
  # Eve::API::Services::Character::   api.character.market_orders
  # Eve::API::Services::Character::   api.character.notifications
  # Eve::API::Services::Character::   api.character.research
  # Eve::API::Services::Character::   api.character.wallet_journal(account_key = 1000, options = {})
  # Eve::API::Services::Character::   api.character.journal_entries(account_key = 1000, options = {})
  # Eve::API::Services::Character::   api.character.wallet_transactions(options = {})
  # Eve::API::Services::Corporation:: api.corporation.account_balance
  # Eve::API::Services::Corporation:: api.corporation.asset_list
  # Eve::API::Services::Corporation:: api.corporation.container_log
  # Eve::API::Services::Corporation:: api.corporation.corporation_sheet(corporation_id = nil)
  # Eve::API::Services::Corporation:: api.corporation.fac_war_stats
  # Eve::API::Services::Corporation:: api.corporation.industry_jobs
  # Eve::API::Services::Corporation:: api.corporation.kill_log(options = {})
  # Eve::API::Services::Corporation:: api.corporation.market_orders
  # Eve::API::Services::Corporation:: api.corporation.member_security
  # Eve::API::Services::Corporation:: api.corporation.member_security_log
  # Eve::API::Services::Corporation:: api.corporation.member_tracking
  # Eve::API::Services::Corporation:: api.corporation.starbase_detail(item_id, version = 2)
  # Eve::API::Services::Corporation:: api.corporation.starbase_list
  # Eve::API::Services::Corporation:: api.corporation.shareholders
  # Eve::API::Services::Corporation:: api.corporation.standings
  # Eve::API::Services::Corporation:: api.corporation.titles
  # Eve::API::Services::Corporation:: api.corporation.wallet_journal(account_key = 1000, options = {})
  # Eve::API::Services::Corporation:: api.corporation.wallet_transactions(account_key = 1000, options = {})
  #
  # === Interpreting Responses
  # Response objects are generated automatically, and should be able to accommodate any changes in the API reasonably
  # well.
  #
  # The classes listed above attempt to document the API calls. However, if you are unsure of
  # how to process the return value of a particular API call, don't be afraid to check it out directly:
  #   irb(main):004:0> puts api.server_status.to_yaml
  #   ---
  #   current_time: 2010-03-14T04:41:51+00:00
  #   cached_until: 2010-03-14T04:44:51+00:00
  #   online_players: 30694
  #   server_open: true
  #   api_version: "2"
  #
  # In this example, #server_status provides 5 fields: #api_version, #cached_until, #current_time, #online_players,
  # and #server_open.
  #
  # Some fields in a given response are essentially arrays with some additional fields. These are called Rowsets. For
  # instance, the call to +api.account.characters+, above, returned a response with a #characters method, which
  # contained up to 3 characters. Each element, or Row, in a Rowset has in turn its own fields and/or Rowsets. Each
  # character in this example includes a #character_id, #corporation_id, and #corporation_name.
  #
  # Additionally, all responses always have a #name field. For basic responses, the #name is "(Response)", and
  # probably doesn't mean much to you. For Rowsets, the #name is the name of the Rowset (for example, "characters").
  # For individual Rows, the #name might mean something more useful -- the name of a character, for instance.
  #
  class API
    include Eve::API::Connectivity
    include Eve::API::Services
    attr_reader :options
    attr_reader :map

    def initialize(options = {})
      @options = default_options.merge(options)
      send_includes
      instantiate_submodules
    end

    def set(key, value = nil)
      raise "Key can't be nil" unless key
      if key.kind_of?(Hash)
        key.each { |k, v| set(k, v) }
      else
        if value then @options[key] = value
        else @options.delete key
        end
        [@options[:submodules]].flatten.each do |sub|
          self.send(sub).set(key, value) if sub
        end
      end
    end

    def [](key); @options[key]; end
    def []=(key, value); set(key, value); end

    private
    class << self
      def validate_credentials(key_type, *args)
        case key_type
          when :limited, :full
            args.flatten!
            options = args.extract_options!
            method_names = options.delete(:for)
            raise ArgumentError, "Unexpected options: #{options.keys.inspect}" unless options.empty?

            method_names.each do |method_name|
              define_method "#{method_name}_with_credential_validation" do |*a|
                validate_credentials(key_type, *args)
                send("#{method_name}_without_credential_validation", *a)
              end
              alias_method_chain method_name, :credential_validation
            end

          else raise ArgumentError, "Expected :limited or :full credential type"
        end
      end
    end

    def validate_credentials(type, *additional_requirements)
      raise ArgumentError, "user_id is required" unless options[:user_id]
      raise ArgumentError, "api_key is required" unless options[:api_key]
      additional_requirements.each do |r|
        raise ArgumentError, "#{r} is required" unless options[r]
      end

      case type
        when :limited, :full # currently no difference. Wish we could validate on this.
        else raise ArgumentError, "Expected :limited or :full credential type"
      end
    end
    
    def validate_options(options, *keys)
      options.keys.each do |key|
        raise ArgumentError, "Options should only include #{keys.inspect}" unless keys.include?(key)
      end
    end

    def send_includes
      [@options[:includes]].flatten.each do |mod|
        next unless mod
        mod = mod.to_s unless mod.kind_of?(String)
        mod = "::Eve::API::Services::#{mod.camelize}".constantize
        eigenclass.send(:include, mod)
      end
    end

    def instantiate_submodules
      [@options[:submodules]].flatten.each do |mod|
        next unless mod
        instance_variable_set("@#{mod}", ::Eve::API.new(options.merge(:includes => mod, :submodules => nil)))
        eigenclass.send(:attr_reader, mod)
        eigenclass.send(:public, mod)
      end
    end

    def eigenclass
      class << self; self; end
    end

    def default_options
      {
        :submodules => [:map, :eve, :account, :character, :corporation],
        :cache => true
      }
    end

    def cache_namespace
      self.class.name.underscore
    end
  end
end
