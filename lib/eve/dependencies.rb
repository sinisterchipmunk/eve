require 'net/http'
require 'hpricot'
require 'yaml'
require 'action_pack'
require 'action_controller'
require 'action_view'
require 'sc-core-ext'

gem_path = File.expand_path(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift gem_path

# moved to autoload to make gem more future-proof
#ActiveSupport::Dependencies.load_paths.unshift gem_path
#ActiveSupport::Dependencies.load_once_paths.unshift gem_path

module Eve
  autoload :Errors, "eve/errors"
  autoload :Helpers, "eve/helpers"
  autoload :Trust, "eve/trust"
end
