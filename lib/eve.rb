$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'eve/dependencies'

module Eve
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
      @cache = defined?(Rails.cache) ? Rails.cache : ActiveSupport::Cache.lookup_store(*cache_store)
      @cache
    end
  end
end
