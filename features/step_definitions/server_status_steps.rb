When /^I request the server status$/ do
  @result = Eve::API.server_status
end

Then /^the result should include "([^\"]*)"$/ do |method_name|
  @result.should respond_to(method_name)
end
