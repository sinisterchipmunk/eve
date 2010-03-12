$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'eve/dependencies'
require 'eve/core_extensions'
require 'eve/errors'
require 'eve/api'
require 'eve/trust'
require 'eve/helpers'

module Eve
  VERSION = '0.0.1'

  class << self
    def cache_store
      @cache_store ||= [:file_store, "tmp/eve.cache"]
    end

    def cache_store=(a)
      @cache_store = [a].flatten
      @cache = ActiveSupport::Cache.lookup_store(a) if @cache
    end

    def cache
      return @cache if @cache
      @cache = defined?(Rails) ? Rails.cache : ActiveSupport::Cache.lookup_store(*cache_store)
#      @cache.logger = Logger.new($stdout) unless defined?(Rails)
      @cache
    end
  end
end
