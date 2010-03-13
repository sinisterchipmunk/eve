require 'eve/api/request'
require 'eve/api/response'
require 'eve/api/services'
require 'eve/api/connectivity'

module Eve
  # = Eve API Libraries
  # Documentation in progress.
  # 
  # Usage examples (copy-and-paste-ready):
  #
  #   require 'rubygems'
  #   require 'eve'
  #   #
  #   # Get the current server status
  #   api = Eve::API.new()
  #   server_status = api.server_status
  #   puts "Server reports status #{server_status.server_open ? "ONLINE" : "OFFLINE"}"
  #   puts "\tCurrent time is #{server_status.current_time}"
  #   puts "\t#{server_status.online_players} players currently online"
  #   puts
  #   #
  #   # Get a list of characters
  #   api = Eve::API.new(:user_id => $user_id, :api_key => $limited_api_key)
  #   result = api.account.characters
  #   puts "Choose a character:"
  #   result.characters.each_with_index { |char, index| puts "\t#{index}: #{char.name} (#{char.character_id})" }
  #   choice = gets.chomp.to_i
  #   puts
  #   #
  #   # Get a character sheet
  #   api.set(:api_key => $full_api_key, :character_id => result.characters[choice].character_id)
  #   character_sheet = api.character.character_sheet
  #   puts "#{character_sheet.name}:"
  #   print "\tCharisma:    \t #{character_sheet.attributes.charisma}    \n"
  #   print "\tIntelligence:\t #{character_sheet.attributes.intelligence}\n"
  #   print "\tMemory:      \t #{character_sheet.attributes.memory}      \n"
  #   print "\tPerception:  \t #{character_sheet.attributes.perception}  \n"
  #   print "\tWillpower:   \t #{character_sheet.attributes.willpower}   \n"
  #   puts
  #   #
  #   # Get the current training queue
  #   result = api.character.skill_queue
  #   result.skillqueue.each do |skill|
  #     result.skillqueue.columns.each do |column|
  #       print column, ":\t\t", skill[column], "\n"
  #     end
  #     puts
  #   end
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
        eigenclass.send(:include, "::Eve::API::Services::#{mod.camelize}".constantize)
      end
    end

    def instantiate_submodules
      [@options[:submodules]].flatten.each do |mod|
        next unless mod
        instance_variable_set("@#{mod}", ::Eve::API.new(options.merge(:includes => mod, :submodules => nil)))
        eigenclass.send(:attr_reader, mod)
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
