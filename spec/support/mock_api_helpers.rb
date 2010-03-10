module MockAPIHelpers
  def mock_response_body(namespace, service)
    service = service.to_s.underscore
    fi = File.expand_path File.join("spec/support/xml", namespace.to_s, "#{service}.xml")
    raise "Cannot find mock request for (#{namespace}, #{service}) - expected it in #{fi}" unless File.file?(fi)
    return File.read(fi)
  end

  def mock_http_response(namespace, service)
    mock = mock('Net::HTTPOK', :body => mock_response_body(namespace, service))
  end
end

Spec::Runner.configure do |config|
  config.include(MockAPIHelpers)
end

puts 'running'