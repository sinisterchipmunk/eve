When /^I request portrait with character ID "([^\"]*)"$/ do |character_id|
  @result = Eve::API.new.character_portrait(:character_id => character_id)
end

Then /^the result should be a (\w+)$/ do |constant_name|
  @result.should be_a(constant_name.constantize)
end
