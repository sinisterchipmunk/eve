require 'eve/api/request'
require 'eve/api/response'
require 'eve/api/services'
require 'eve/api/connectivity'

module Eve
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
        :submodules => [:map, :eve, :account, :character],
        :cache => true
      }
    end

    def cache_namespace
      self.class.name.underscore
    end
  end
end
