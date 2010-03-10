unless defined?(Gem)
  require 'rubygems'
  gem 'hpricot', '>= 0.8.2'
  gem 'activesupport', '>= 2.3.5'
end

require 'net/http'
require 'hpricot'
require 'active_support/core_ext'
require 'active_support/cache'
require 'active_support/memoizable'
require 'yaml'
