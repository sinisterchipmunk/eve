unless defined?(Gem)
  require 'rubygems'
  gem 'hpricot',       '>= 0.8.2'
  gem 'actionpack',    '>= 2.3.5'
  gem 'activesupport', '>= 2.3.5'
end

require 'net/http'
require 'hpricot'
require 'yaml'
require 'action_pack'
require 'action_controller'
require 'action_view'
