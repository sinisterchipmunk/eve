module MockAPIHelpers
  def eve_api(options = {})
    @eve_api ||= {}
    @eve_api[ActiveSupport::Cache.expand_cache_key(options)] ||= ::Eve::API.new(options)
  end
  alias api eve_api

  def mock_response_body(base, service = nil)
    if service.nil?
      fi = File.expand_path File.join("spec/support", base)
    else
      namespace = base
      service = service.to_s.underscore
      fi = File.expand_path File.join("spec/support/xml", namespace.to_s, "#{service}.xml")
    end
    raise "Cannot find mock request for (#{base}, #{service}) - expected it in #{fi}" unless File.file?(fi)
    return File.read(fi)
  end

  def mock_http_response(base, service = nil)
    mock = mock('Net::HTTPOK', :body => mock_response_body(base, service))
  end

  def mock_service(base, options = {}, more_options = {})
    options = { :service => options } unless options.kind_of?(Hash)
    options.merge! more_options
    if $mock_services
      Net::HTTP.should_receive(:post_form).any_number_of_times.and_return(mock_http_response(base,
                                                                                             options[:service]))
    end
    if options[:service] && eve_api(options).respond_to?(base)
      eve_api(options).send(base).send(options[:service], *(options[:args] || []))
    # If having trouble with mock services, this may be of some help, but it alters how the API can be
    # interacted with (most notably for spec/lib/eve/api/calls/server_status_spec.rb) so it should be
    # disabled when no issues are showing up.
#    elsif options[:service]
#      raise "Service '#{options[:service]}' specified but API doesn't respond to '#{base}'"
    else
      eve_api(options)
    end
  end
end

RSpec.configure do |config|
  config.include(MockAPIHelpers)
end
