require File.dirname(__FILE__) + '/../lib/eve'

# Note that these don't matter unless mock responses are disabled.
$user_id         = '01234567890'
$limited_api_key = 'a_valid_limited_api_key'
$full_api_key    = 'a_valid_full_api_key'
$character_id    = '0123456789'

# Set to false to disable mock web service responses. Real requests will be used
# whenever Eve.cache does not suffice. The API information above must be real and
# valid in this case.
$mock_services  = true

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
