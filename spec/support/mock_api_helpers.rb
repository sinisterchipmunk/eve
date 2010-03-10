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

  def mock_service(base, service = nil)
    Net::HTTP.should_receive(:post_form).any_number_of_times.and_return(mock_http_response(base, service))
  end
end

Spec::Runner.configure do |config|
  config.include(MockAPIHelpers)
end
