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

gem_path = File.expand_path(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift gem_path
ActiveSupport::Dependencies.load_paths.unshift gem_path
ActiveSupport::Dependencies.load_once_paths.unshift gem_path
