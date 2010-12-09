require 'rubygems'
require File.join(File.dirname(__FILE__), '../lib/eve')
require 'rails'
##require "active_record/railtie"
require "action_controller/railtie"
##require "action_mailer/railtie"
##require "active_resource/railtie"
require "rails/test_unit/railtie"
#require 'rails/all'
require 'rspec/rails'

# set up Rails3 mock application
module Eve
  class MockRailsApplication < Rails::Application
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.active_support.deprecation = :log
  end
end

# Initialize Rails3 mock application
Eve::MockRailsApplication.initialize!

# Set up routing - this is necessary to match params hashes to their controllers/actions,
# and must come AFTER the app is initialized. If app is initialized, routes are cleared.
Eve::MockRailsApplication.routes.draw { match ':controller(/:action(/:id(.:format)))' }


# Set to false to disable mock web service responses. Real requests will be used
# whenever Eve.cache does not suffice. The API information above must be real and
# valid in this case.
$mock_services  = true

keyfile = File.join(File.dirname(__FILE__), 'api_key.yml')
cred_hash = !$mock_services && File.file?(keyfile) ? YAML::load(File.read(keyfile)) || {} : {}

# ! IMPORTANT !
# It's a lot safer to put this information in a file called "api_key.yml" in the same
# directory as spec_helper.rb. This file is in the .gitignore list and so you won't
# accidentally commit your API key that way. Leave the hash below for FAKE data (which
# is what you'll usually spec with anyways), unless $mock_services == false.
#
$user_id         = cred_hash['User ID']         || '01234567890'
$limited_api_key = cred_hash['Limited API Key'] || 'a_valid_limited_api_key'
$full_api_key    = cred_hash['Full API Key']    || 'a_valid_full_api_key'
$character_id    = cred_hash['Character ID']    || '0123456789'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each { |f| require f }
