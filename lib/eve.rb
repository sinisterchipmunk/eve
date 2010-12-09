$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'eve/dependencies'
require 'eve/errors'
require 'eve/api'
require 'eve/trust'
require 'eve/helpers'

module Eve
  class Railtie < Rails::Railtie
    Mime::Type.register_alias "text/html", :eve
    Mime::Type.register_alias "text/html", :igb

    # TODO should this be #to_prepare with ApplicationController, instead?
    config.after_initialize do
      ActionController::Base.instance_eval do
        include Eve::Trust::ControllerHelpers
      end
    end
  end
  
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
      @cache
    end
  end
end
