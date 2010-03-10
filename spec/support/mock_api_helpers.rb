module MockAPIHelpers
  def mock_request(namespace, service)
    fi = File.expand_path File.join("spec/support/xml", namespace.to_s, "#{service}.xml")
    raise "Cannot find mock request for (#{namespace}, #{service}) - expected it in #{fi}" unless File.file?(fi)
    return File.read(fi)
  end
end

Spec::Runner.configure do |config|
  config.include(MockAPIHelpers)
end

puts 'running'